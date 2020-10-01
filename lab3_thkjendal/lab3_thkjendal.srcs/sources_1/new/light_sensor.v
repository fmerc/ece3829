`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/28/2020 04:05:41 PM
// Design Name: 
// Module Name: light_sensor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:                                     insert description
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module light_sensor(
    input       clk,        // 10 MHz clock signal
    input       reset,      // reset
    input       sdo,        // master in slave out
    output reg  sclk,       // serial clock (1 Hz)
    output reg  cs,         // chip select (active high)
    output [7:0] light_val  // 8-bit light readings
    );

    // 10 to 1 MHz clock divider - Slow Clock
    reg [3:0] count = 0;    // clk counter
    always @ (posedge clk) begin
        sclk <= (count <= 4) ? 1 : 0;
        count <= (count == 9) ? 0 : count + 1;
    end
    
    // 1 MHz to 2Hz clock divider - Chip Select
    reg [18:0]  count_cs = 0;
    always @ (posedge sclk) begin
        cs <= (count_cs < 16) ? 0 : 1;    
        count_cs <= (count_cs >= 499_999) ? 0 : count_cs + 1;    
    end

    
    // READ LIGHT SENSOR
    
    parameter [1:0] s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;
    wire    rst_shift, start_shift, end_shift;
    reg     [3:0]   count_shift = 4'b0;     // track number of shifts (8)
    reg     [14:0]  read = 15'b0;           // buffer to load sdo onto
    reg     [1:0]   current_state = s0,     // track current and next states 
                    next_state = s0;
    
    always @ (posedge sclk, posedge reset)  // handle resets
        current_state <= (reset) ? s0 : next_state;
    
    // state machine
    always @ (current_state, sclk, cs, count_shift)
        case (current_state)
            s0: next_state = (sclk && !cs) ? s1 : s0;   // wait for control to start sequence
            s1: next_state = s2;                        // reset shift register
            s2: next_state = s3;                        // start shift register
            s3: next_state = (count_shift == 15) ? s0 : s3;     // wait for shift to finish
        endcase
    assign rst_shift = current_state == s1;
    assign start_shift = current_state == s2 || current_state == s3;
    
    // shifter
    always @ (posedge sclk)
        if (rst_shift) begin
            count_shift <= 0;
            read <= 8'b0;
        end
        else if (start_shift) begin
            read <= {read[13:0], sdo};
            count_shift <= count_shift + 1;
        end
    
    assign light_val = read[11:4];

endmodule

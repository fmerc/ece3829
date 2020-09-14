`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/12/2020 12:11:10 PM
// Design Name: 
// Module Name: slowclock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Creates a 1 Hz clock (cyles every 1 second)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module slowclock(
    input       clk_in,     // input clock (25 MHz)
    output  reg clk_out,    // output clock (1Hz)
    output  reg clk_out2    // output clock 2 (60Hz)
    );
     
    reg [23:0] count = 0;
    reg [23:0] count2 = 0;
    
    // 25_000_000 / 12_500_000 = 2 up down cycle
    always @ (posedge clk_in) begin
        if (count == 12500000) begin
            count   <= 0; 
            clk_out <= !clk_out;
        end
        else
            count   <= count + 1;
    end
        
    // 25_000_000 / 100_000 = 120 up down cycle
    always @ (posedge clk_in) begin
        if (count2 == 100000) begin
            count2   <= 0; 
            clk_out2 <= !clk_out2;
        end
        else
            count2  <= count2 + 1;
    end
        
endmodule

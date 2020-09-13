`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/12/2020 02:59:41 PM
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Simple 8-bit counter, led for testing purposes
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input   clk,
    input   [7:0] c1_max,
    input   [7:0] c2_max,
    output  [7:0] count1,
    output  [7:0] count2,
    output  led
    );
    
    reg [7:0] c1 = 0;   // initial count of 0
    reg [7:0] c2 = 0;   // initial count of 0
    reg c1_up = 1;      // c1 counts up if 1, counts down if 0
    reg c2_up = 1;      // c2 counts up if 1, counts down if 0
    reg state = 0;      // led state, 0 = off, 1 = on
    
    assign count1 = c1;
    assign count2 = c2;
    assign led = state;
    
    always @ (posedge clk) begin
        // counter 1
        if (c1_up) begin        // count up
            if (c1 >= c1_max)   
                c1_up <= 0;     // count down if max is reached
            else
                c1 <= c1 + 1;   // increment c1 otherwise
        end
        else if (!c1_up)  begin // count down
            if (c1 == 0)
                c1_up <= 1;     // count up if 0 is reached
            else
                c1 <= c1 - 1;   // decrement c1 otherwise
        end
        
        // counter 2 copy of counter 1
        if (c2_up) begin        // count up
            if (c2 >= c2_max)   
                c2_up <= 0;     // count down if max is reached
            else
                c2 <= c2 + 1;   // increment c2 otherwise
        end
        else if (!c2_up)  begin // count down
            if (c2 == 0)
                c2_up <= 1;     // count up if 0 is reached
            else
                c2 <= c2 - 1;   // decrement c2 otherwise
        end
        
        state <= !state;    // blink led each cycle
        
    end
    
endmodule

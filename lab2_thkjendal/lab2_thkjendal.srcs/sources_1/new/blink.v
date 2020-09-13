`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/12/2020 03:22:05 PM
// Design Name: 
// Module Name: blink
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Blinks an led once per second, used to test slowclock
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blink(
    input         clk,
    output        led
    );
    
    reg    state = 0;
    assign led = state;
    
    always @ (posedge clk) begin
        state <= !state;
    end
    
endmodule

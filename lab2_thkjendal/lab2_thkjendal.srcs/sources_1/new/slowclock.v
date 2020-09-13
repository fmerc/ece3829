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
    input       clk_in, // input clock (25 MHz)
    output  reg clk_out // output clock (1Hz)
    );
     
    reg [23:0] count = 0;
    
    always @ (posedge clk_in) 
    if (count == 12500000) begin
        count   <= 0; 
        clk_out <= !clk_out;
    end
    else
        count   <= count + 1;
        
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/08/2020 01:48:32 AM
// Design Name: 
// Module Name: lab2_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top module, creates 25MHz clk, instantiates peripheral modules.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab2_top(
    input           [15:0] sw,  // 16-bit input
    input           clk_fpga,   // 100 MHz clock
    output  wire    [6:0] seg,  // 7-bit connector
    output  wire    [3:0] an    // 4-bit connector
    );
    
    wire    clk_25MHz;
    
    clk_wiz_0 mmcm (.clk_25MHz),        // output clock (25Mhz)
                    .reset(),           // input reset
                    .locked(),          // output locked
                    .clk_in1(clk_fpga));// input clock
    
    seven_seg seg1( .in(sw),
                    .clk(clk_25MHz),
                    .seg(seg),
                    .an(an));
    
    
    
    
endmodule

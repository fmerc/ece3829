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
    input           reset,      // BTNC reset
    output  wire    [6:0] seg,  // 7-bit connector
    output  wire    [3:0] an,   // 4-bit connector
    output  [3:0]   vga_r, vga_g, vga_b,
    output          vga_hs, vga_vs
    );
    
    wire    clk_25MHz;
    
    clk_wiz_0 mmcm (
            // input
            .reset(reset),          // input reset
            .clk_in1(clk_fpga),     // input clock (100MHz)
            // output
            .clk_25MHz(clk_25MHz),  // output clock (25Mhz)
            .locked());             // output locked
            
              
    wire  [7:0] vga_in;
    
    vga_display disp1 (
            // input
            .clk_25MHz(clk_25MHz),
            .reset(reset),
            .in(vga_in),
            .sw(sw[3:0]),
            // output
            .red(vga_r),
            .green(vga_g),
            .blue(vga_b),
            .HS(vga_hs),
            .VS(vga_vs));
    
    seven_seg seg1 (
            // input
            .in(sw),
            .clk(clk_25MHz),
            // output
            .seg(seg),
            .an(an));
    
    
    
    
endmodule

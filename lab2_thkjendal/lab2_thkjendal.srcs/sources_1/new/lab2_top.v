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
    input      [15:0] sw,       // 16-bit input
    input             clk_fpga, // 100 MHz clock
    input             reset,    // BTNC reset
    output wire [6:0] seg,      // 7-bit connector
    output wire [3:0] an,       // 4-bit connector
    output      [3:0] vga_r, vga_g, vga_b,
    output            vga_hs, vga_vs
    );
    
    // MMCM
    wire    clk_25MHz;
    clk_wiz_0 mmcm (
            .reset(reset),          // input reset
            .clk_in1(clk_fpga),     // input clock (100MHz)
            .clk_25MHz(clk_25MHz),  // output clock (25MHz)
            .locked());             // output locked
    
    
    // 1Hz CLOCK
    wire    clk_1Hz;
    wire    clk_60Hz;
    slowclock sclk (.clk_in(clk_25MHz), // input (25MHz)
                    .clk_out(clk_1Hz),  // output (1Hz)
                    .clk_out2(clk_60Hz) // output (60Hz)
                    );
    
    
    // VGA CONTROLLER
    wire    [10:0]  hcount, vcount;
    wire    blank;
    vga_controller_640_60 vga (
        // input
        .rst(reset),
        .pixel_clk(clk_25MHz),
        // output
        .HS(vga_hs),
        .VS(vga_vs),
        .hcount(hcount),
        .vcount(vcount),
        .blank(blank));
             
                    
    // VGA COLOR LOGIC
    vga_display disp1 ( 
            // input
            .clk_1Hz(clk_1Hz),
            .sw(sw[3:0]),
            .blank(blank),
            .hcount(hcount),
            .vcount(vcount),
            // output
            .red(vga_r),
            .green(vga_g),
            .blue(vga_b));
    
    
    // SEVEN SEGMENT DISPLAY
    seven_seg seg1 (
            // input
            .in(sw),
            .clk(clk_25MHz),
            // output
            .seg(seg),
            .an(an));
    
endmodule

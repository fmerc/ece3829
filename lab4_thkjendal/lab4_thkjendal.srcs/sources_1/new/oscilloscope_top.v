`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 10/10/2020 06:11:48 PM
// Design Name: 
// Module Name: oscilloscope_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Uses a VGA controller and light sensor to create a digital oscilloscope.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module oscilloscope_top(
    // MMCM
    input             clk_fpga, // 100 MHz clock
    input             reset,    // BTNC reset
    // LIGHT SENSOR
    input   ls_sdo,
    output  ls_sclk, ls_cs,
    // VGA DISPLAY
    output      [3:0] vga_r, vga_g, vga_b,  // vga rgb values
    output            vga_hs, vga_vs,       // vga hsync/vsync
    // 7 SEG DISPLAY
    output wire [6:0] sseg_seg, // 7 seg cathodes
    output wire [3:0] sseg_an   // 7 seg anodes
    );
    
    // MMCM
    wire    clk_25M, clk_10M;
    clk_wiz_0 MMCM1 (
        .clk_in1(clk_fpga), // Clock in (100 MHz) 
        .clk_25M(clk_25M),  // Clock out 1 (25 MHz)
        .clk_10M(clk_10M),  // Clock out 2 (10 MHz)
        .reset(reset),      // Status and control signals
        .locked()
        );
        
    // LIGHT SENSOR SPI INTERFACE
    wire    [7:0] light_val;
    light_sensor SPI1 (
        .clk(clk_10M),          // input clock (10MHz)
        .reset(reset),          // input reset
        .sdo(ls_sdo),           // input master-in-slave-out
        .sclk(ls_sclk),         // output slowclock (1MHz)
        .cs(ls_cs),             // output chip select
        .light_val(light_val)   // output light sensor values
        );
    
    // VGA CONTROLLER
    wire    [10:0]  hcount, vcount;
    wire    blank;
    vga_controller_640_60 VGA1 (
        // input
        .rst(reset),
        .pixel_clk(clk_25MHz),
        // output
        .HS(vga_hs), .VS(vga_vs),
        .hcount(hcount), .vcount(vcount),
        .blank(blank)
        );
             
    // VGA COLOR LOGIC
    vga_color DISP1 ( 
        // input
        .clk(clk_25MHz),
        .reset(reset),
        .blank(blank),
        .hcount(hcount), .vcount(vcount),
        // output
        .red(vga_r), .green(vga_g), .blue(vga_b)
        );
    
    
    // SEVEN SEGMENT DISPLAY
    seven_seg SEG1 (
        .in({8'h92, light_val}),// input data
        .clk(clk_10M),          // input clock (10MHz)
        .seg(sseg_seg),         // output segment
        .an(sseg_an)            // output anodes
        );
    
    
endmodule

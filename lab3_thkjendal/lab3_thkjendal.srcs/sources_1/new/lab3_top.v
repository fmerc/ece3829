`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/28/2020 03:24:29 PM
// Design Name: 
// Module Name: lab3_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:                             Insert Description
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab3_top(
    input       clk_fpga,
    input       reset,
    
    input       sdo,
    output      sclk,
    output      cs,
    
    output wire [6:0]   sseg_disp,
    output wire [3:0]   sseg_enable
    );
    
    // MMCM
    wire    clk_10M;
    clk_wiz_0 MMCM (
            .reset(reset),          // input reset
            .clk_in1(clk_fpga),     // input clock (100MHz)
            .clk_10M(clk_10M),      // output clock (10MHz)
            .locked());             // output locked
    
    // SPI interface
    wire    [7:0] light_val;
    light_sensor SPI1(
            .clk(clk_10M),          // input clock (10MHz)
            .reset(reset),          // input reset
            .sdo(sdo),              // input master-in-slave-out
            .sclk(sclk),            // output slowclock (1MHz)
            .cs(cs),                // output chip select
            .light_val(light_val)   // output light sensor values
            );
    
    // SEVEN SEGMENT DISPLAY
    seven_seg SEG1 (
            .in({8'h92, light_val}),// input data
            .clk(clk_10M),          // input clock (10MHz)
            .seg(sseg_disp),        // output segment
            .an(sseg_enable));      // output anodes
    
endmodule

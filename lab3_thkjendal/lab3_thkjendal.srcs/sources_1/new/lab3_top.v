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
    output wire [6:0]   sseg_disp,
    output wire [3:0]   sseg_enable
    );
    
    // MMCM
    wire    clk_10M;
    clk_wiz_0 mmcm (
            .reset(reset),          // input reset
            .clk_in1(clk_fpga),     // input clock (100MHz)
            .clk_10M(clk_10M),      // output clock (10MHz)
            .locked());             // output locked
    
    
    
    // SEVEN SEGMENT DISPLAY
    seven_seg seg1 (
            // input
            .in(16'HFF92),
            .clk(clk_10M),
            // output
            .seg(sseg_disp),
            .an(sseg_enable));
    
endmodule

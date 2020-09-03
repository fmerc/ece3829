`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2020 07:51:47 PM
// Design Name: 
// Module Name: lab1_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab1_top(
    input   [15:0] sw,
    input   [1:0] btn,
    output  wire    [6:0] seg,
    output  wire    [3:0] an,
    output          [15:0] led
    );
    
    seven_seg disp (.A(sw[3:0]), .B(sw[7:4]), .C(sw[11:8]), .D(sw[15:12]), 
                    .SEL(btn), .seg(seg), .an(an));
    
    assign led[3:0]   = sw[3:0] + sw[7:4];  // A + B
    assign led[11:4]  = sw[3:0] * sw[7:4];  // A * B
    assign led[15:12] = 4'b0010;            // Last Digit of WPI ID (2)
    
endmodule

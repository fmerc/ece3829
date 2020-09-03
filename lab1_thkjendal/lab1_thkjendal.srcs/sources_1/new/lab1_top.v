`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai "Hunter" Kjendal
// 
// Create Date: 09/02/2020 07:51:47 PM
// Design Name: 
// Module Name: lab1_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Instantiates a 4-digit 7-segment display, which outputs values corresponding 
//              to 16 switches. Individual digits are chosen with the left and right push 
//              buttons (selector switch). LED outputs are: 4-bit constant, 8-bit product of 
//              A and B, 4-bit sum of A and B.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab1_top(
    input           [15:0] sw,  // 16 switches (four sets of 4-bit selectors)
    input           [1:0] btn,  // 2 buttons (2-bit selector)
    output  wire    [6:0] seg,  // 7-bit connector
    output  wire    [3:0] an,   // 4-bit connector
    output          [15:0] led  // 16-bit LED output
    );
    
    seven_seg disp (.A(sw[3:0]),    // input A == first four switches
                    .B(sw[7:4]),    // input B == next four switches
                    .C(sw[11:8]),   // input C == next four switches
                    .D(sw[15:12]),  // input D == last four switches
                    .SEL(btn),      // input SEL == two buttons (BTNL, BTNR)
                    .seg(seg),      // output seg:  7 segment display values
                    .an(an));       // output an:   4 anodes
    
    assign led[3:0]   = sw[3:0] + sw[7:4];  // A + B
    assign led[11:4]  = sw[3:0] * sw[7:4];  // A * B
    assign led[15:12] = 4'b0010;            // Last Digit of WPI ID (2)
    
endmodule

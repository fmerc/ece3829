`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai "Hunter" Kjendal
// 
// Create Date: 09/02/2020 06:49:32 PM
// Design Name: 
// Module Name: seven_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Drives a 4-digit 7-segment display on an FPGA, 
//              requires four 4-bit inputs, one 2-bit input, 
//              and outputs for the display.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg(
    input       [3:0] A,    // input A, switches 0-3
    input       [3:0] B,    // input B, switches 4-7
    input       [3:0] C,    // input C, switches 8-11
    input       [3:0] D,    // input D, switches 12-15
    input       [1:0] SEL,  // selector, left & right push buttons
    output  reg [6:0] seg,  // 7-segment cathodes
    output  reg [3:0] an    // 7-segment anodes
    );
    
    reg     [3:0] in; // select between 4 inputs
    
    // 7 segment display constants (0-F)
    parameter zero  =   7'b1000000; // 7-segment '0'
    parameter one   =   7'b1111001; // 7-segment '1'
    parameter two   =   7'b0100100; // '2'
    parameter three =   7'b0110000; // '3'
    parameter four  =   7'b0011001; // '4'
    parameter five  =   7'b0010010; // '5'
    parameter six   =   7'b0000010; // '6'
    parameter seven =   7'b1111000; // '7'
    parameter eight =   7'b0000000; // '8'
    parameter nine  =   7'b0010000; // '9'
    parameter aaaa  =   7'b0001000; // 'A'
    parameter bbbb  =   7'b0000011; // 'b'
    parameter cccc  =   7'b1000110; // 'C'
    parameter dddd  =   7'b0100001; // 'd'
    parameter eeee  =   7'b0000110; // 'E'
    parameter ffff  =   7'b0001110; // 'F'
    
    
    always @ (SEL) begin
        // For each SEL case, turn on corresponding anode, 
        //    and connect corresponding input
        case (SEL)          
            2'b00: begin    
                an = 4'b1110;   // turn on first (right most) 7-seg
                in = A; end     // set input to 'A' switches
            2'b01: begin    
                an = 4'b1101;   // turn on second 7-seg
                in = B; end     // set input to 'B' switches
            2'b10: begin    
                an = 4'b1011;   // turn on third 7-seg
                in = C; end     // set input to 'C' switches
            2'b11: begin    
                an = 4'b0111;   // turn on last (left most) 7-seg 
                in = D; end     // set input to 'D' switches
            default: an = 4'b1111;
        endcase
        
        // display 7-segment digit corresponding to 4-bit value 'in'
        case (in)   
            4'b0000: seg = zero;
            4'b0001: seg = one;
            4'b0010: seg = two;
            4'b0011: seg = three;
            4'b0100: seg = four;
            4'b0101: seg = five;
            4'b0110: seg = six;
            4'b0111: seg = seven;
            4'b1000: seg = eight;
            4'b1001: seg = nine;
            4'b1010: seg = aaaa;
            4'b1011: seg = bbbb;
            4'b1100: seg = cccc;
            4'b1101: seg = dddd;
            4'b1110: seg = eeee;
            4'b1111: seg = ffff;
        endcase
        
    end
    
endmodule

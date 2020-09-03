`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2020 06:49:32 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(
    input       [3:0] A,      
    input       [3:0] B,
    input       [3:0] C,
    input       [3:0] D,      
    input       [1:0] SEL,  // selector
    output  reg [6:0] seg,  // 7-segment cathodes
    output  reg [3:0] an    // 7-segment anodes
    );
    
    reg     [3:0] in; // select between 4 inputs
    
    // display constants
    parameter zero  =   7'b1000000;
    parameter one   =   7'b1111001;
    parameter two   =   7'b0100100;
    parameter three =   7'b0110000;
    parameter four  =   7'b0011001;
    parameter five  =   7'b0010010;
    parameter six   =   7'b0000010;
    parameter seven =   7'b1111000;
    parameter eight =   7'b0000000;
    parameter nine  =   7'b0010000;
    parameter aaaa  =   7'b0001000;
    parameter bbbb  =   7'b0000011;
    parameter cccc  =   7'b1000110;
    parameter dddd  =   7'b0100001;
    parameter eeee  =   7'b0000110;
    parameter ffff  =   7'b0001110;
    
    
    always @ (SEL) begin
        
        case (SEL)
            2'b00: begin    an = 4'b1110;   in = A; end
            2'b01: begin    an = 4'b1101;   in = B; end
            2'b10: begin    an = 4'b1011;   in = C; end
            2'b11: begin    an = 4'b0111;   in = D; end
            default: an = 4'b1111;
        endcase
        
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/08/2020 12:53:42 AM
// Design Name: 
// Module Name: seven_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Displays a 16-bit value to a 4-digit, seven segment display, at 120 Hz
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg(
    input      [15:0] in,   // 16-bit input
    input             clk,  // 25 MHz clock
    output  reg [6:0] seg,  // 7-segment cathodes
    output  reg [3:0] an    // 7-segment anodes
    );
    
    reg    [18:0] count = 0;    // clk counter
    reg     [1:0] sel = 2'b00;  // initialize a select to switch segments 
    reg     [3:0] n;            // use to cycle segments
        
    // update seven-segment at 60 Hz
    always @ (posedge clk) begin
        if (count == 100000) begin
            count <= 0;
            sel <= (sel == 2'b11) ? 2'b00 : sel + 1;
        end
        else
            count <= count + 1;
    end 
        
    // For each SEL case, turn on corresponding anode, 
    //    and connect corresponding input
    always @ (sel, in) begin
        case (sel)          
            2'b00: begin    
                n = in[3:0];    // set input to 1st 4 switches
                an = 4'b1110;   // set anode to 1st segment
                end 
            2'b01: begin   
                n = in[7:4];    // set input to 2nd 4 switches
                an = 4'b1101;   // set anode to 2nd segment
                end
            2'b10: begin   
                n = in[11:8];   // set input to 3rd 4 switches
                an = 4'b1011;   // set anode to 3rd segment
                end
            2'b11: begin   
                n = in[15:12];  // set input to last 4 switches
                an = 4'b0111;   // set anode to last segment
                end 
        endcase
    end
        
    // 7 segment display constants (0-F)
    parameter zero  =   7'b1000000; // 7-segment '0'
    parameter one   =   7'b1111001; // '1'
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
        
    // display 7-segment digit corresponding to 4-bit value 'n'
    always @ (n) begin
        case (n)   
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

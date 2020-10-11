`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 10/11/2020 10:06:46 AM
// Design Name: 
// Module Name: vga_color
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: VGA display color logic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_color (
    input    clk, reset,    // 25MHz clock and reset
    input         blank,    // blank state
    input  [10:0] hcount, vcount,   // hcount and vcount
    output  [3:0] red, green, blue  // 4-bit rgb outputs
    );
    
    // 512 Hz signal clock
    reg         clk_512;
    reg  [15:0] count_512 = 0;
    always @ (posedge clk) begin
        count_512 <= (count_512 == 0) ? 1 : 0;
        count_512 <= (count_512 >= 48828) ? 0 : count_512 + 1;
    end
    
    // assign rgb outputs
    reg     [11:0]  vga_color;      // hold rgb values
    assign  red     = vga_color[11:8];
    assign  green   = vga_color[7:4];
    assign  blue    = vga_color[3:0];
            
    // color constants
    parameter [11:0] RED    = 12'HF00;
    parameter [11:0] GREEN  = 12'H0F0;
    parameter [11:0] BLUE   = 12'H00F;
    parameter [11:0] YELLOW = 12'HFF0;
    parameter [11:0] WHITE  = 12'HFFF;
    parameter [11:0] BLACK  = 12'H000;
    parameter [11:0] GREY   = 12'H888;
    parameter [11:0] ORANGE = 12'HC71;
    parameter [11:0] CYAN   = 12'H0FF;
    parameter [11:0] PINK   = 12'HC37;
    parameter [11:0] SKY    = 12'HCFF;

    reg [9:0]   c_x;    // square center x
    reg [8:0]   c_y;    // square center y

    // Part 3 x and y counters (wrap)
    always @ (posedge clk_512) begin            
        c_x <= (c_x >= 511) ? 0 : c_x + 1;
    end
    
//    always @ (posedge clk_512) begin            
//        c_y <= (c_y >= 14) ? 0 : c_y + 1;
//    end

    // display mode
    always @ (blank, vcount, hcount, c_y, c_x) begin
        if (blank)
            vga_color <= BLACK;
        else
            vga_color <= (hcount >= 512 && hcount < 0 && vcount >= 256 && vcount < 0) ? BLACK :
                         (hcount < 511 && hcount >= 1 && vcount < 255 && vcount >= 1) ? BLACK : BLUE;
            vga_color <= (hcount == c_x && vcount == 127) ? WHITE : BLACK;
    end
    
endmodule

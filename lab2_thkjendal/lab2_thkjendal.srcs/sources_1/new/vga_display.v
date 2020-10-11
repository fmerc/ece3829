`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/08/2020 09:20:01 AM
// Design Name: 
// Module Name: vga_display
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


module vga_display (
    input   clk,            // 25MHz clock
    input   [3:0] sw,       // 4-bit slider input
    input         blank,    // blank state
    input  [10:0] hcount, vcount,   // hcount and vcount
    output  [3:0] red, green, blue  // 4-bit rgb outputs
    );
    
    
    // 1 Hz signal clock
    reg     clk_1Hz;
    reg     [23:0] count_clk1;
    always @ (posedge clk) begin
        if (count_clk1 == 12_500_000) begin
            count_clk1 <= 0;
            clk_1Hz <= ~clk_1Hz;
        end
        else
            count_clk1 <= count_clk1 + 1;
    end
    // 60 Hz signal clock
    reg     clk_60Hz;
    reg     [23:0] count_clk2;
    always @ (posedge clk) begin
        if (count_clk2 == 200_000) begin
            count_clk2 <= 0;
            clk_60Hz <= ~clk_60Hz;
        end
        else
            count_clk2 <= count_clk2 + 1;
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
    reg [9:0]   c_x2;    // square center x2
    reg [8:0]   c_y2;    // square center y2

    // Part 3 x and y counters (wrap)
    always @ (posedge clk_1Hz) begin            
        c_x <= (c_x >= 19) ? 0 : c_x + 1;
    end
    
    always @ (posedge clk_1Hz) begin            
        c_y <= (c_y >= 14) ? 0 : c_y + 1;
    end
    
    // Extra credit x and y counters (bounce)
    reg i = 1, j = 1;   // when one, x2 and y2 count up, count down otherwise
    reg [2:0]   sel_color = 0;      // change between 8 colors when the square hits a border
    always @ (posedge clk_60Hz) begin
        if (i) begin
            if (c_x2 == 576) begin
                sel_color <= sel_color + 1; // increment color select (change color)
                i <= !i;                    // change counter direction
            end
            else c_x2 <= c_x2 + 2;
        end
        else if (!i) begin
            if (c_x2 == 0) begin
                sel_color <= sel_color + 1;
                i <= !i;
            end
            else c_x2 <= c_x2 - 2;
        end
    end
    
    always @ (posedge clk_60Hz) begin   // y2 counter         
        if (j) begin
            if (c_y2 == 416) j <= !j;
            else c_y2 <= c_y2 + 1;
        end
        else if (!j) begin
            if (c_y2 == 0) j <= !j;
            else c_y2 <= c_y2 - 1;
        end
    end
    
    // choose color from sel_color
    wire [11:0] color;
    assign color = (sel_color==0) ? RED    : 
                   (sel_color==1) ? GREEN  : 
                   (sel_color==2) ? BLUE   : 
                   (sel_color==3) ? YELLOW : 
                   (sel_color==4) ? ORANGE :
                   (sel_color==5) ? CYAN   : 
                   (sel_color==6) ? PINK   : 
                   SKY;

    // display mode
    always @ (blank, vcount, hcount, sw, c_x, c_y, c_x2, c_y2, color) begin
        if (blank)
            vga_color <= BLACK;
        else begin
            case (sw)
                4'b0000:    // green screen
                    vga_color <= GREEN;
                4'b0001:    // 16 pixel wide red & yellow bars (vertical)
                    vga_color <= (hcount/16 %16 %2==0) ? RED : YELLOW;
                4'b0010:    // 64x64 blue block on black background (top right)
                    vga_color <= (hcount > 575 && hcount <= 640 &&
                                    vcount >= 0 && vcount < 64) ? 
                                    BLUE : BLACK;
                4'b0011:    // 32x32 white block on black background (top left)
                    vga_color <= (hcount < 32 && hcount >= 0 &&
                                    vcount <32 && vcount >= 0) ? 
                                    WHITE : BLACK;
                
                4'b0100:    // 32x32 white block, black background, block 
                            // moves down 1 , right 1 at 1Hz
                    vga_color <= (hcount < (c_x*32 + 32) && hcount >= (c_x*32) &&
                                  vcount < (c_y*32 + 32) && vcount >= (c_y*32)  ) ? 
                                  WHITE : BLACK;
//                    if (hcount < counter+32 && hcount >= counter) vga_color = WHITE; ....
                
                4'b0101:
                    vga_color <= (  hcount < (c_x2 + 64) && hcount >= c_x2 &&
                                    vcount < (c_y2 + 64) && vcount >= c_y2  ) ? 
                                  color : GREY;                
                    
                default:    // default state: black screen 
                    vga_color <= BLACK;
            endcase
        end
    end
    
endmodule

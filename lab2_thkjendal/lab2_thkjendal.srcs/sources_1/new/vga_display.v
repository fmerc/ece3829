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


module vga_display(
    input   clk_1Hz,        // 1Hz clock
    input   [3:0] sw,       // 4-bit slider input
    input         blank,    // blank state
    input  [10:0] hcount, vcount,   // hcount and vcount
    output  [3:0] red, green, blue  // 4-bit rgb outputs
    );
    
    // assign rgb outputs
    reg     [11:0]  vga_color;      // hold rgb values
    assign  red     = vga_color[11:8];
    assign  green   = vga_color[7:4];
    assign  blue    = vga_color[3:0];
            
    // color constants             Red_Green_Blue
    parameter [11:0] RED     = 12'b1111_0000_0000;
    parameter [11:0] GREEN   = 12'b0000_1111_0000;
    parameter [11:0] BLUE    = 12'b0000_0000_1111;
    parameter [11:0] YELLOW  = 12'b1111_1111_0000;
    parameter [11:0] WHITE   = 12'b1111_1111_1111;
    parameter [11:0] BLACK   = 12'b0000_0000_0000;

    reg [8:0]   c_x;    // square center x
    reg [7:0]   c_y;    // square center y
    
//    counter count_xy(.clk(clk_1Hz),
//                     .c1_max(8'b00010011),  // x counts 0 to 19
//                     .c2_max(8'b00001110),  // y counts 0 to 14
//                     .count1(c_x),
//                     .count2(c_y),
//                     .led(led));

    // Part 3 x and y counters
    always @ (posedge clk_1Hz) begin            
        c_x <= (c_x >= 19) ? 0 : c_x + 1;
    end
    
    always @ (posedge clk_1Hz) begin            
        c_y <= (c_y >= 14) ? 0 : c_y + 1;
    end

    // Extra credit
    // print namis jeff on screen

    // display mode
    always @ (blank, vcount, hcount, sw, c_x, c_y) begin
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
                
                4'b0100:
                    vga_color <= (hcount < (c_x + 32) && hcount >= c_x &&
                                  vcount < (c_y + 32) && vcount >= c_y) ? 
                                  WHITE : BLACK;
//                    if (hcount < counter+32 && hcount >= counter) vga_color = WHITE; ....
                
                4'b0101: begin
                    
                
                end
                    
                default:    // default state: black screen 
                    vga_color <= BLACK;
            endcase
        end
    end
    
endmodule

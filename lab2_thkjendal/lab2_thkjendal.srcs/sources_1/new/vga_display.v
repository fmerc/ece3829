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
    input   clk_25MHz,      // 25MHz clock
    input   clk_1Hz,        // 1Hz clock
    input   reset,          // reset
    input   [7:0] in,       // 8-bit input
    input   [3:0] sw,       // 4-bit slider input
    output  [3:0] red,      // 4-bit rgb outputs
    output  [3:0] green,
    output  [3:0] blue,
    output  HS, VS          // horizontal, vertical sync
    );

    wire    blank;                  // 
    wire    [10:0]  hcount, vcount; // 
    reg     [11:0]  vga_color;      // hold rgb values
    
    vga_controller_640_60 vga (
            // input
            .rst(reset),
            .pixel_clk(clk_25MHz),
            // output
            .HS(HS),
            .VS(VS),
            .hcount(hcount),
            .vcount(vcount),
            .blank(blank));
    
    // assign rgb outputs
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

    reg [5:0] c_x = 0;  // counter x
    reg [4:0] c_y = 0;  // counter y
    always @ (posedge clk_1Hz) begin
        if (c_x == 19 || c_y == 15) begin
            c_x = 0;
            c_y = 0;
        end
        else begin
            c_x <= c_x + 1;
            c_y <= c_y + 1;
        end
    end

    // display mode
    always @ (vcount, hcount, sw, blank, c_x, c_y) begin
    
        if (blank)
            vga_color <= BLACK;
        else begin
            case (sw)
                4'b0000:    // green screen
                    vga_color <= GREEN;
                4'b0001:    // 16 pixel wide red & yellow bars (vertical)
                    vga_color <= (hcount/16 %16 %2==0) ? RED : YELLOW;
                4'b0010:    // 64x64 blue block on black background (top right)
                    vga_color <= (hcount > 575 && vcount < 64) ? BLUE : BLACK;
                4'b0011:    // 32x32 white block on black background (top left)
                    vga_color <= (hcount < 32 && vcount <32) ? WHITE : BLACK;
                
                4'b0100: begin
                    vga_color <= (hcount+c_x < 32+c_x && hcount+c_x >= c_x &&
                                  vcount+c_y < 32+c_y && vcount+c_y >= c_y) ? 
                                  BLUE : RED;
                    
                end
                    
                default:    // default state: black screen 
                    vga_color <= BLACK;
            endcase

        end
    end
    
endmodule

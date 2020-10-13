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
    input         sw,       // switch to select mode
    input   [7:0] light_val,        // 8 bit light sensor values
    input  [10:0] hcount, vcount,   // hcount and vcount
    output  [3:0] red, green, blue  // 4-bit rgb outputs
    );
    
    // 512 Hz signal clock
    reg         clk_512;
    reg  [15:0] count_512 = 0;
    always @ (posedge clk) begin
        clk_512 <= (count_512 == 0) ? 1 : 0;
        count_512 <= (count_512 >= 48828) ? 0 : count_512 + 1;
    end
    
    // assign rgb outputs
    reg     [11:0]  vga_color;      // hold rgb values
    assign  red     = vga_color[11:8];
    assign  green   = vga_color[7:4];
    assign  blue    = vga_color[3:0];
            
    // color constants
    parameter [11:0] BLUE   = 12'H00F;
    parameter [11:0] WHITE  = 12'HFFF;
    parameter [11:0] BLACK  = 12'H000;

    reg [8:0]   c_x = 0;    // x coordinate

    // counter for horizantle moving pixel
    always @ (posedge clk_512)            
        c_x <= c_x + 1;
    
    // 512x256 1-wide border
    assign border_on = (hcount <= 512 && hcount > 0 && vcount < 256 && vcount >= 0) &&  // outer border bounds
                        !(hcount <= 511 && hcount > 1 && vcount < 255 && vcount >= 1);  // inner border bounds
    
    // moving pixel (light_val is inverted so FF corresponds to zero 
    //     coordinate, and 00 corresponds to max coordinate)
    assign pixel_on = (hcount == c_x) && (vcount == (light_val ^ 8'HFF));


    // TEXT
    wire [7:0] char_pos_x;
    wire [5:0] char_pos_y;
    wire [2:0] font_col;
    
    wire [3:0] font_t_addr;
    reg  [7:0] font_t_data;
    
    wire [3:0] font_h_addr;
    reg  [7:0] font_h_data;
    
    wire [3:0] font_k_addr;
    reg  [7:0] font_k_data;
    
    // 8x16 character font
    always @ (font_t_addr)
        case (font_t_addr)
            4'h0:   font_t_data = 8'hFE;  // character 'T'
            4'h1:   font_t_data = 8'h10;
            4'h2:   font_t_data = 8'h10;
            4'h3:   font_t_data = 8'h10;
            4'h4:   font_t_data = 8'h10;
            4'h5:   font_t_data = 8'h10;
            4'h6:   font_t_data = 8'h10;
            4'h7:   font_t_data = 8'h10;
            4'h8:   font_t_data = 8'h10;
            default: font_t_data = 8'h00;
        endcase
        
    always @ (font_h_addr)
        case (font_h_addr)
            4'h0:   font_h_data = 8'h82;  // character 'H'
            4'h1:   font_h_data = 8'h82;
            4'h2:   font_h_data = 8'h82;
            4'h3:   font_h_data = 8'h82;
            4'h4:   font_h_data = 8'hFE;
            4'h5:   font_h_data = 8'h82;
            4'h6:   font_h_data = 8'h82;
            4'h7:   font_h_data = 8'h82;
            4'h8:   font_h_data = 8'h82;
            default: font_h_data = 8'h00;
        endcase
        
    always @ (font_k_addr)
        case (font_k_addr)
            4'h0:   font_k_data = 8'h82;  // character 'K'
            4'h1:   font_k_data = 8'h84;
            4'h2:   font_k_data = 8'h88;
            4'h3:   font_k_data = 8'h90;
            4'h4:   font_k_data = 8'hA0;
            4'h5:   font_k_data = 8'hD0;
            4'h6:   font_k_data = 8'h88;
            4'h7:   font_k_data = 8'h84;
            4'h8:   font_k_data = 8'h82;
            default: font_k_data = 8'h00;
        endcase
    
    // 80x30 array of pixels
    assign char_pos_x = hcount[10:3];   // character y pos
    assign char_pos_y = vcount[9:4];    // character x pos
    
    // three character position
    assign char_pos_1 = (char_pos_x == 66) && (char_pos_y == 2);
    assign char_pos_2 = (char_pos_x == 67) && (char_pos_y == 2);
    assign char_pos_3 = (char_pos_x == 68) && (char_pos_y == 2);
    
    assign font_col = hcount[2:0];  // font column address
    assign font_t_addr = vcount[3:0]; // least significant 4 bits creates row address
    assign font_h_addr = vcount[3:0];
    assign font_k_addr = vcount[3:0];
    assign font_t_bit = font_t_data[~font_col]; // select correct bit to display in row
    assign font_h_bit = font_h_data[~font_col];
    assign font_k_bit = font_k_data[~font_col];
    
    
    // display 'THK'
    assign char_on = (char_pos_1 & font_t_bit) | (char_pos_2 & font_h_bit) | (char_pos_3 & font_k_bit);
    
//    // TRACE PIXEL POSITION
//    reg [7:0] trace [8:0];      // 512 8-bit registers
//    always @ (c_x, light_val)
//        trace[c_x] <= light_val;
    
//    assign trace_on = (vcount == trace[c_x]);


    // DRAW THE DISPLAY
    always @ (blank, border_on, pixel_on, char_on) begin
        if (blank)
            vga_color <= BLACK;
        else
            if (pixel_on)
                vga_color <= WHITE;
//            else if (sw && trace_on)
//                vga_color <= WHITE;
            else if (char_on)
                vga_color <= WHITE;
            else if (border_on)
                vga_color <= BLUE;
            else
                vga_color <= BLACK;
    end
    
endmodule

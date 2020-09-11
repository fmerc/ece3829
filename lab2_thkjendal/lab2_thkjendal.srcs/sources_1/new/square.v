`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/11/2020 12:15:19 PM
// Design Name: 
// Module Name: square
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A square that can be animated
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module square(
    input   wire i_clk,         // base clock
    input   wire i_ani_sub,     // animation clock (1 pixel per frame)
    input   wire i_rst,         // resets animation
    input   wire i_animate,     // animate on active high
    output  wire [11:0] o_x1,   // square left edge
    output  wire [11:0] o_x2,   // square right edge
    output  wire [11:0] o_y1,   // square top edge
    output  wire [11:0] o_y2    // square bottom edge
    );
    
    reg [11:0] x = 320;         // horizantle pos of square center
    reg [11:0] y = 240;         // vertical pos of square center
    reg x_dir = 1;              // horizantle animation direction
    reg y_dir = 1;              // vertical animation direction
    
    assign o_x1 = x - 80;
    assign o_x2 = x + 80;
    assign o_y1 = y - 80;
    assign o_y2 = y + 80;
    
    always @ (posedge i_clk) begin
        if (i_rst) begin
            x <= 320;
            y <= 240;
            x_dir <= 1;
            y_diy <= 1;
        end
        if (i_animate && i_ani_stb) begin
            if (x <= 320 + 1)  // edge of square is at left of screen
                x_dir <= 1;  // change direction to right
            if (x >= (D_WIDTH - H_SIZE - 1))  // edge of square at right
                x_dir <= 0;  // change direction to left          
            if (y <= H_SIZE + 1)  // edge of square at top of screen
                y_dir <= 1;  // change direction to down
            if (y >= (D_HEIGHT - H_SIZE - 1))  // edge of square at bottom
                y_dir <= 0;  // change direction to up
        end 
    end
    
endmodule

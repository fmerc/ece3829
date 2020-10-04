`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tai Kjendal
// 
// Create Date: 09/30/2020 10:18:49 AM
// Design Name: 
// Module Name: als_tf
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Test the functionality of sclk and cs, to verify that 
//              their timing is correct.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module als_tf;
    
    // inputs
    reg clk, sdo, reset;
    
    // outputs
    wire sclk, cs;
    wire [7:0] light_val;
    wire [6:0] sseg_disp;
    wire [3:0] ssen_an;
    
    // instantiate UUT
    light_sensor #(.cs_delay(1000)) uut(.clk(clk), .reset(reset), .sdo(sdo),            // I
                                        .sclk(sclk), .cs(cs), .light_val(light_val));   // O
                                        
    seven_seg   seg1(.in({8'H92, light_val}), .clk(clk),    // I 
                     .seg(sseg_disp), .an(sseg_an));        // O
            
    // 10MHz clock signal, 50% duty cycle
    always begin
        clk = 0;
        #50;
        clk = 1;
        #50;
    end
    
    initial begin
        // print header
        $display("testing SCLK and CS signals with Test Fixture");
        
        sdo = 0;
        
        reset = 1;
        #1000;
        reset = 0;
        #1000;
        
        wait (cs==1)
        wait (cs==0)
        sdo = 0;
        #3000;  // first 3 bits are zero, buffer should read 000_10111110_0000
        sdo = 1;
        #4000;
        sdo = 0;
        #4000;
        sdo = 0;
        #5000;
        
        
        
        
        
        
    end
    
endmodule

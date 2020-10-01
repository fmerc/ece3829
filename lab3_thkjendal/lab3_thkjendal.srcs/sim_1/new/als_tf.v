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
// Description:                     Description
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module als_tf;
    
    // inputs
    reg clk, sdo;
    
    // outputs
    wire sclk, cs;
    wire [7:0] light_val;
    
    // instantiate UUT
    light_sensor uut(
            .clk(clk),
            .sdo(sdo),
            .sclk(sclk),
            .cs(cs),
            .light_val(light_val));
            
    // 10MHz clock signal, 50% duty cycle
    always begin
        clk = 0;
        #50;
        clk = 1;
        #50;
    end
    
    initial begin
        sdo = 0;
        
        // print header
        $display("testing SCLK and CS signals with Test Fixture");
        
        
        
    end
    
endmodule

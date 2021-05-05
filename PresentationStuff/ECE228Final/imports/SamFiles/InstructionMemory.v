`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sam Lewandoski
// 
// Create Date: 05/02/2021 08:11:49 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input clk,
    input im_rst,
    input im_ld_en,
    input [25:0] im_instLoad,
    output reg [25:0] im_IW
    );
    
    reg [25:0] im_instructions[31:0];
    reg [4:0] im_counter;

    always@(posedge clk)
    begin
    if(im_rst == 1)
        im_counter <= 5'd0;
    else
        im_counter <= im_counter+5'd1;
    end
    
    always@(posedge clk)
    begin
        if (im_ld_en) im_instructions[im_counter] <= im_instLoad;
        else im_IW <= im_instructions[im_counter][25:0];
    end
    
endmodule

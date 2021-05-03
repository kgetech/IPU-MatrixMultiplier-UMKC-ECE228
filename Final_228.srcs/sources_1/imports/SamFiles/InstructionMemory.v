`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    input rst,
    output reg [25:0] IW
    );
    
    reg [25:0] instructions[31:0];
    reg [4:0] counter;

    always@(posedge clk | rst)
    begin
    if(rst == 1)
    counter <= 5'd0;
    else
    counter <= counter+5'd1;
    end
    
    always@(posedge clk)
    begin
    IW <= instructions[counter][25:0];
    end
    
endmodule

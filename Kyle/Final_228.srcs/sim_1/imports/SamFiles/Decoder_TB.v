`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2021 10:14:59 PM
// Design Name: 
// Module Name: Decoder_TB
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


module Decoder_TB;
    reg [25:0] IW_tb;
    reg clk;
    wire [3:0] AA_tb;
    wire [3:0] AB1_tb;
    wire [3:0] AB2_tb;
    wire [3:0] AB3_tb;
    wire [3:0] AB4_tb;
    wire [3:0] DA_tb;
    wire DMX_tb;
    wire mm_en_tb;
    wire add_en_tb;
    wire MUXD_tb;
    wire rf_rw_tb;
    wire rf_am_tb;
    
    Decoder uut(
    .IW(IW_tb),
    .AA(AA_tb),
    .AB1(AB1_tb),
    .AB2(AB2_tb),
    .AB3(AB3_tb),
    .AB4(AB4_tb),
    .DA(DA_tb),
    .DMX(DMX_tb),
    .mm_en(mm_en_tb),
    .add_en(add_en_tb),
    .MUXD(MUXD_tb),
    .rf_rw(rf_rw_tb),
    .rf_am(rf_am_tb)
    );
  
    initial
    begin
    clk = 1'b0;
    IW_tb = {2'b1, 4'd5, 4'd4, 4'd3, 4'd2, 4'd1, 4'd0};
    end
    always #10
    clk = ~clk;
   
    
endmodule

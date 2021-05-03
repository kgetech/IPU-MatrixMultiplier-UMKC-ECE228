`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2021 09:57:30 PM
// Design Name: 
// Module Name: Decoder
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


module Decoder(
    input [25:0] IW,
    input clk,
    output reg [3:0] DA,
    output reg [3:0] AA,
    output reg [3:0] AB1,
    output reg [3:0] AB2,
    output reg [3:0] AB3,
    output reg [3:0] AB4,
    output reg DMX, 
    output reg mm_en,
    output reg [1:0] add_en,
    output reg MUXD,
    output reg rf_rw,
    output reg rf_am
    );
    reg [31:0] IW0;

    always@(posedge clk)
    begin
        IW0 <= IW;
        if(IW0[25] == 0 & IW0[24] == 0) //ADD 
        begin
            DA[3:0] <= IW0[23:20];
            AA[3:0] <= IW0[19:16];
            AB1[3:0] <= IW0[15:12];
            DMX <= 1'b1;
            mm_en <= 1'b0;
            add_en <= 2'b01;
            MUXD <= 1'b1;
            rf_rw <= 1'b1;
            rf_am <= 1'b1;
        end
        else if(IW0[25] == 0 & IW0[24] == 1) //MLT
        begin
            DA[3:0] <= IW0[23:20];
            AA[3:0] <= IW0[19:16];
            AB1[3:0] <= IW0[15:12];
            AB2[3:0] <= IW[11:8];
            AB3[3:0] <= IW[7:4];
            AB4[3:0] <= IW[3:0];
            DMX <= 1'b0;
            mm_en <= 1'b1;
            add_en <= 2'b00;
            MUXD <= 1'b0;
            rf_rw <= 1'b1;
            rf_am <= 1'b0;
        end
        else if(IW0[25] == 1 & IW0[24] == 0) //MV
        begin
            DA[3:0] <= IW[23:20];
            AA[3:0] <= IW[19:16];
            DMX <= 1'b1;
            mm_en <= 1'b0;
            add_en <= 2'b10;
            MUXD <= 1'b1;
            rf_rw <= 1'b1;
        end
        else if(IW0[25] == 1 & IW0[24] == 1) //WT
        begin
            rf_rw <= 1'b0;
        end
    end
endmodule

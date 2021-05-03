`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 05/02/2021
// Module Name: mat_add
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////

module mat_add(
        input clk,
        input [1:0] ma_add_en,
        input [15:0] ma_A, ma_B,
        output reg [15:0] ma_S,
        output reg ma_OF
    );
    
    wire [3:0] ma_OFt;
    wire [15:0] ma_At, ma_Bt, ma_St;
    
    
    FA_nb ma_FA1(
        .fa_A(ma_At[15:12]), 
        .fa_B(ma_Bt[15:12]), 
        .fa_S(ma_St[15:12]),
        .fa_OF(ma_OFt[0])
    );
    
    FA_nb ma_FA2(
        .fa_A(ma_At[11:8]), 
        .fa_B(ma_Bt[11:8]), 
        .fa_S(ma_St[11:8]),
        .fa_OF(ma_OFt[1])
    );
    
    FA_nb ma_FA3(
        .fa_A(ma_At[7:4]), 
        .fa_B(ma_Bt[7:4]), 
        .fa_S(ma_St[7:4]),
        .fa_OF(ma_OFt[2])
    );
    
    FA_nb ma_FA4(
        .fa_A(ma_At[3:0]), 
        .fa_B(ma_Bt[3:0]), 
        .fa_S(ma_St[3:0]),
        .fa_OF(ma_OFt[3])
    );
    
    always@(posedge clk)
    begin
    case(ma_add_en)
        2'b01 :
        begin
            ma_OF <= |ma_OFt;
            ma_S <= ma_St;
        end
        2'b00 : ma_S <= 16'bZZ; //this is probably going to be wrong
        default: ma_S <= ma_A;
    endcase
    end
    
endmodule

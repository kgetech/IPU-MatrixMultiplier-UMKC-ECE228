`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/29/2021
// Module Name: ipu_top
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module ipu_top(
    input top_clk,
    input top_rw, top_am, top_mm_en,
    input [15:0] top_inRow,
    input [3:0] top_AA, top_DA,
    input [15:0] top_AB,
    output [15:0] top_OA, top_MC, 
    output [63:0] top_OB, 
    output top_mm_OF
    );
    

    register_file top_rf(
        .clk(top_clk), 
        .rf_rw(top_rw), 
        .rf_am(top_am),
        .rf_inRow(top_inRow), 
        .rf_AA(top_AA), 
        .rf_AB4(top_AB[3:0]), 
        .rf_AB3(top_AB[7:4]), 
        .rf_AB2(top_AB[11:8]), 
        .rf_AB1(top_AB[15:12]), 
        .DA(top_DA), 
        .rf_OA(top_OA), 
        .rf_OB4(top_OB[15:0]), 
        .rf_OB3(top_OB[31:16]), 
        .rf_OB2(top_OB[47:32]), 
        .rf_OB1(top_OB[63:48])
        );
        
    matrix_multi top_mm(
        .clk(top_clk),
        .mm_en(top_mm_en),
        .mm_A(top_OA),
        .mm_B1(top_OB[63:48]), 
        .mm_B2(top_OB[47:32]),
        .mm_B3(top_OB[31:16]),
        .mm_B4(top_OB[15:0]),
        .mm_C(top_MC),
        .mm_OF(top_mm_OF)
        );
    
    
    
endmodule

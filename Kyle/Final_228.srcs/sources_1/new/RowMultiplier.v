`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/27/2021
// Module Name: row_multi
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////

module RowMultiplier
    #(parameter BIT_WIDTH=4)(
    input [(BIT_WIDTH*4)-1:0] rm_X,rm_Y,
    output reg [(BIT_WIDTH*4)-1:0] rm_C,
    output rm_OF
    );
    
    wire rm_OF_1, rm_OF_2, rm_OF_3, rm_OF_4; //overflow flags
    assign rm_OF = (rm_OF_1 | rm_OF_2 | rm_OF_3 | rm_OF_4);
    
    multi_nb rm_multi_1(.A(rm_X[BIT_WIDTH-1:0]), .B(rm_Y[BIT_WIDTH-1:0]), .P(rm_Z[BIT_WIDTH-1:0]), .OF(rm_OF_1));
    multi_nb rm_multi_2(.A(rm_X[BIT_WIDTH*2-1:BIT_WIDTH]), .B(rm_Y[BIT_WIDTH*2-1:BIT_WIDTH]), .P(rm_Z[BIT_WIDTH*2-1:BIT_WIDTH]), .OF(rm_OF_2));
    multi_nb rm_multi_3(.A(rm_X[BIT_WIDTH*3-1:BIT_WIDTH*2]), .B(rm_Y[BIT_WIDTH*3-1:BIT_WIDTH*2]), .P(rm_Z[BIT_WIDTH*3-1:BIT_WIDTH*2]), .OF(rm_OF_3));
    multi_nb rm_multi_4(.A(rm_X[BIT_WIDTH*4-1:BIT_WIDTH*3]), .B(rm_Y[BIT_WIDTH*4-1:BIT_WIDTH*3]), .P(rm_Z[BIT_WIDTH*4-1:BIT_WIDTH*3]), .OF(rm_OF_4));
    wire [(BIT_WIDTH*4)-1:0] rm_Z
    FA_nb rm_add_1();
    
endmodule

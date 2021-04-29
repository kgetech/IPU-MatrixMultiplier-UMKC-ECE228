`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/27/2021
// Module Name: row_multi
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////

module row_multi
    #(parameter BIT_WIDTH=4)(
    input [(BIT_WIDTH*4)-1:0] rm_A,rm_B,
    output reg [BIT_WIDTH-1:0] rm_C,
    output rm_OF
    );
    
    wire rm_OF_1, rm_OF_2, rm_OF_3, rm_OF_4, rm_OF_5, rm_OF_6, rm_OF_7; //overflow flags
    assign rm_OF = (rm_OF_1 | rm_OF_2 | rm_OF_3 | rm_OF_4 | rm_OF_5 | rm_OF_6 | rm_OF_7);
    
    multi_nb rm_multi_1(.m_A(rm_A[BIT_WIDTH-1:0]), .m_B(rm_B[BIT_WIDTH-1:0]), .m_P(rm_Z[BIT_WIDTH-1:0]), .m_OF(rm_OF_1));
    multi_nb rm_multi_2(.m_A(rm_A[BIT_WIDTH*2-1:BIT_WIDTH]), .m_B(rm_B[BIT_WIDTH*2-1:BIT_WIDTH]), .m_P(rm_Z[BIT_WIDTH*2-1:BIT_WIDTH]), .m_OF(rm_OF_2));
    multi_nb rm_multi_3(.m_A(rm_A[BIT_WIDTH*3-1:BIT_WIDTH*2]), .m_B(rm_B[BIT_WIDTH*3-1:BIT_WIDTH*2]), .m_P(rm_Z[BIT_WIDTH*3-1:BIT_WIDTH*2]), .m_OF(rm_OF_3));
    multi_nb rm_multi_4(.m_A(rm_A[BIT_WIDTH*4-1:BIT_WIDTH*3]), .m_B(rm_B[BIT_WIDTH*4-1:BIT_WIDTH*3]), .m_P(rm_Z[BIT_WIDTH*4-1:BIT_WIDTH*3]), .m_OF(rm_OF_4));
    wire [(BIT_WIDTH*4)-1:0] rm_Z;
    wire [(BIT_WIDTH*2)-1:0] rm_Zt;
    wire [BIT_WIDTH-1:0] rm_Zc;

    FA_nb rm_add_1(.fa_A(rm_Z[(BIT_WIDTH*4)-1:BIT_WIDTH*3]), .fa_B(rm_Z[(BIT_WIDTH*3)-1:BIT_WIDTH*2]), .fa_S(rm_Zt[(BIT_WIDTH*2)-1:BIT_WIDTH]), .fa_OF(rm_OF_5));
    FA_nb rm_add_2(.fa_A(rm_Z[(BIT_WIDTH*2)-1:BIT_WIDTH]), .fa_B(rm_Z[BIT_WIDTH-1:0]), .fa_S(rm_Zt[BIT_WIDTH-1:0]), .fa_OF(rm_OF_6));
    FA_nb rm_add_3(.fa_A(rm_Zt[(BIT_WIDTH*2)-1:BIT_WIDTH]), .fa_B(rm_Zt[BIT_WIDTH-1:0]), .fa_S(rm_Zc), .fa_OF(rm_OF_7));
    always@(*) rm_C <= rm_Zc;
endmodule

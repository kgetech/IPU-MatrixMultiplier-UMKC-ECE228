`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/29/2021
// Module Name: row_multi_TB
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////

module row_multi_TB;
    parameter TB_BIT_WIDTH=4;
    reg [(TB_BIT_WIDTH*4)-1:0] tb_A,tb_B;
    wire [(TB_BIT_WIDTH)-1:0] tb_C;
    wire tb_OF;
    row_multi rm_DUT(.rm_A(tb_A), .rm_B(tb_B), .rm_C(tb_C), .rm_OF(tb_OF));
    
    initial
    begin
        #5;
        tb_A <= {4'd1,4'd0,4'd0,4'd0};
        tb_B <= {4'd2,4'd0,4'd0,4'd0};
        #5;
        $display("[A][B][C]: [%d %d %d %d] [%d %d %d %d] [%d]",
            tb_A[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_A[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_A[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_A[TB_BIT_WIDTH-1:0],
            tb_B[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_B[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_B[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_B[TB_BIT_WIDTH-1:0], tb_C);
        #5;
        tb_A <= {4'd0,4'd2,4'd0,4'd0};
        tb_B <= {4'd0,4'd2,4'd0,4'd0};
        #5;
        $display("[A][B][C]: [%d %d %d %d] [%d %d %d %d] [%d]",
            tb_A[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_A[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_A[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_A[TB_BIT_WIDTH-1:0],
            tb_B[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_B[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_B[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_B[TB_BIT_WIDTH-1:0], tb_C);
        #5;
        tb_A <= {4'd0,4'd0,4'd3,4'd0};
        tb_B <= {4'd0,4'd0,4'd2,4'd0};
        #5;
        $display("[A][B][C]: [%d %d %d %d] [%d %d %d %d] [%d]",
            tb_A[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_A[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_A[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_A[TB_BIT_WIDTH-1:0],
            tb_B[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_B[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_B[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_B[TB_BIT_WIDTH-1:0], tb_C);
        #5;
        tb_A <= {4'd0,4'd0,4'd0,4'd4};
        tb_B <= {4'd0,4'd0,4'd0,4'd2};
        #5;
        $display("[A][B][C]: [%d %d %d %d] [%d %d %d %d] [%d]",
            tb_A[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_A[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_A[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_A[TB_BIT_WIDTH-1:0],
            tb_B[TB_BIT_WIDTH*4-1:TB_BIT_WIDTH*3], 
            tb_B[TB_BIT_WIDTH*3-1:TB_BIT_WIDTH*2], 
            tb_B[TB_BIT_WIDTH*2-1:TB_BIT_WIDTH], 
            tb_B[TB_BIT_WIDTH-1:0], tb_C);
        #5;
        $finish;
    end
endmodule

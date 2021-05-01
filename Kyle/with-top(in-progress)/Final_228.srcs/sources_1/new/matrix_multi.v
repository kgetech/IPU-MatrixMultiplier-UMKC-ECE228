`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/29/2021
// Module Name: matrix_multi
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module matrix_multi
    #(parameter MM_BIT_WIDTH = 4)(
    input clk, mm_en,
    input [MM_BIT_WIDTH*4 - 1:0] mm_A, mm_B1, mm_B2, mm_B3, mm_B4,
    output reg [MM_BIT_WIDTH*4 - 1:0] mm_C,
    output reg mm_OF
    );
    wire [3:0] mm_OFt;
    row_multi #(.RM_BIT_WIDTH(MM_BIT_WIDTH)) mm_rm1(.rm_A(mm_A), .rm_B(mm_B1), .rm_C(mm_Ct[MM_BIT_WIDTH*4 - 1:MM_BIT_WIDTH*3]), .rm_OF(mm_OFt[0]));
    row_multi #(.RM_BIT_WIDTH(MM_BIT_WIDTH)) mm_rm2(.rm_A(mm_A), .rm_B(mm_B2), .rm_C(mm_Ct[MM_BIT_WIDTH*3 - 1:MM_BIT_WIDTH*2]), .rm_OF(mm_OFt[1]));
    row_multi #(.RM_BIT_WIDTH(MM_BIT_WIDTH)) mm_rm3(.rm_A(mm_A), .rm_B(mm_B3), .rm_C(mm_Ct[MM_BIT_WIDTH*2 - 1:MM_BIT_WIDTH]), .rm_OF(mm_OFt[2]));
    row_multi #(.RM_BIT_WIDTH(MM_BIT_WIDTH)) mm_rm4(.rm_A(mm_A), .rm_B(mm_B4), .rm_C(mm_Ct[MM_BIT_WIDTH- 1:0]), .rm_OF(mm_OFt[3]));
    wire [MM_BIT_WIDTH*4 - 1:0] mm_Ct;
    always@(posedge clk) 
    begin
        if(mm_en == 1) 
        begin
            mm_C <= mm_Ct;
            mm_OF <= |mm_OFt;
        end
        else 
        begin
            mm_C <= {MM_BIT_WIDTH*4{1'b0}};
            mm_OF = 1'b0;
        end
    end
endmodule

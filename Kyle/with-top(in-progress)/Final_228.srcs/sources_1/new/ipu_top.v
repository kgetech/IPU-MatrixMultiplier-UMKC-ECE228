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
    parameter TOP_BIT_WIDTH = 4;  //todo: parametrize the register file (keep this at 4)
    parameter TOP_SIG_WIDTH = TOP_BIT_WIDTH + 5;
    
    //just for experimental purposes
    reg [9:0] top_cSig;
    
/*    
    i_reg #(.IN_MSB(9), .OUT_MSB(1)) IR1();    //demultiplexers
    i_reg #(.IN_MSB(7), .OUT_MSB(1)) IR2();     //enables
    i_reg #(.IN_MSB(5), .OUT_MSB(0)) IR3();     //multiplexer
    i_reg #(.IN_MSB(4), .OUT_MSB(4)) IR4();       //writeback
*/  
    
    reg [TOP_SIG_WIDTH:0] top_inxt1;
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR1(      //demuxes
        .ir_inADMX(top_cSig[TOP_SIG_WIDTH]),   
        .ir_inBDMX(top_cSig[TOP_SIG_WIDTH - 1]),   
        .ir_inmm_en(top_cSig[TOP_SIG_WIDTH - 2]),  
        .ir_inadd_en(top_cSig[TOP_SIG_WIDTH - 3]), 
        .ir_inMUXD(top_cSig[TOP_SIG_WIDTH - 4]),   
        .ir_inrw(top_cSig[TOP_SIG_WIDTH - 5]),     
        .ir_inDA(top_cSig[TOP_BIT_WIDTH - 1:0]),
        .ir_outADMX(top_inxt1[TOP_SIG_WIDTH]),   
        .ir_outBDMX(top_inxt1[TOP_SIG_WIDTH - 1]),   
        .ir_outmm_en(top_inxt1[TOP_SIG_WIDTH - 2]),  
        .ir_outadd_en(top_inxt1[TOP_SIG_WIDTH - 3]), 
        .ir_outMUXD(top_inxt1[TOP_SIG_WIDTH - 4]),   
        .ir_outrw(top_inxt1[TOP_SIG_WIDTH - 5]),     
        .ir_outDA(top_inxt1[TOP_BIT_WIDTH-1:0]));
          
    reg [TOP_SIG_WIDTH-2:0] top_inxt2; 
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR2(      //enables      
        .ir_inmm_en(top_inxt1[TOP_SIG_WIDTH - 2]),  
        .ir_inadd_en(top_inxt1[TOP_SIG_WIDTH - 3]), 
        .ir_inMUXD(top_inxt1[TOP_SIG_WIDTH - 4]),   
        .ir_inrw(top_inxt1[TOP_SIG_WIDTH - 5]),     
        .ir_inDA(top_inxt1[TOP_BIT_WIDTH - 1:0]),  
        .ir_outmm_en(top_inxt2[TOP_SIG_WIDTH - 2]),  
        .ir_outadd_en(top_inxt2[TOP_SIG_WIDTH - 3]), 
        .ir_outMUXD(top_inxt2[TOP_SIG_WIDTH - 4]),   
        .ir_outrw(top_inxt2[TOP_SIG_WIDTH - 5]),     
        .ir_outDA(top_inxt2[TOP_BIT_WIDTH-1:0]));
    
    reg [TOP_SIG_WIDTH-4:0] top_inxt3;       
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR3(      //muxd  
        .ir_inMUXD(top_inxt2[TOP_SIG_WIDTH - 4]),   
        .ir_inrw(top_inxt2[TOP_SIG_WIDTH - 5]),     
        .ir_inDA(top_inxt2[TOP_BIT_WIDTH - 1:0]),  
        .ir_outMUXD(top_inxt3[TOP_SIG_WIDTH - 4]),   
        .ir_outrw(top_inxt3[TOP_SIG_WIDTH - 5]),     
        .ir_outDA(top_inxt3[TOP_BIT_WIDTH-1:0]));
    
    reg [TOP_SIG_WIDTH-5:0] top_inxt4;     
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR4(      //writeback     
        .ir_inrw(top_inxt3[TOP_SIG_WIDTH - 5]),     
        .ir_inDA(top_inxt3[TOP_BIT_WIDTH - 1:0]),    
        .ir_outrw(top_inxt4[TOP_SIG_WIDTH - 5]),     
        .ir_outDA(top_inxt4[TOP_BIT_WIDTH-1:0]));

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
        
    matrix_multi #(.MM_BIT_WIDTH(TOP_BIT_WIDTH)) top_mm(
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

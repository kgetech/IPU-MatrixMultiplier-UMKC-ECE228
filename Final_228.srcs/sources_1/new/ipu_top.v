`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/29/2021
// Module Name: ipu_top
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////
`define ADD (2'b00)
`define MLT (2'b01)
`define MV (2'b10)
`define WT_RD (2'b11)

module ipu_top(
    input top_rst,
    input top_im_ld_en,
    input top_rf_ld_en,
    input [15:0] top_rf_load,
    input [3:0] top_rf_ld_adrs,
    input [25:0] top_im_instLoad,
    input top_clk,
    output top_OF,
    output [15:0] top_TB_ret,
    output [3:0]  top_ret_adrs
    );
    
    
    
    parameter TOP_BIT_WIDTH = 4;  //todo: parametrize the register file (keep this at 4)
    //parameter TOP_SIG_WIDTH = TOP_BIT_WIDTH + 5;
    
    //(t0)//////////////////////Instruction Memory Module
    
    wire [25:0] top_IW;
    InstructionMemory top_im(
        .clk(top_clk),               
        .im_rst(top_rst),            
        .im_ld_en(top_im_ld_en),          
        .im_instLoad(top_im_instLoad),
        .im_IW(top_IW)  
    );
    
    //(t1)//////////////////////Instruction Decoder
    wire[3:0]   top_DA,
                top_AA,
                top_AB1,
                top_AB2,
                top_AB3,
                top_AB4;
                
    wire [1:0]  top_add_en,
                top_wt_rd;
    
    wire    //top_DMX,
            top_MUXD,
            top_mm_en,
            top_rf_rw,
            top_rf_am;
            
    Decoder top_instDec(
        .IW(top_IW),           
        .clk(top_clk),                
        .DA(top_DA),       
        .AA(top_AA),       
        .AB1(top_AB1),      
        .AB2(top_AB2),      
        .AB3(top_AB3),      
        .AB4(top_AB4),      
        //.DMX(top_DMX),            
        .mm_en(top_mm_en),          
        .add_en(top_add_en),   
        //.MUXD(top_MUXD),           
        .rf_rw(top_rf_rw),          
        .rf_am(top_rf_am),          
        .dec_wt_rd(top_wt_rd)  //mind this
    );
    
    //(t2)(t6)//////////////////////Register File
    reg [15:0] top_to_rf_in;
    wire[3:0]   top_nx4_DA;
    wire    top_nx4_rf_rw;
    wire [15:0] top_OA,
                top_OB1,
                top_OB2,
                top_OB3,
                top_OB4;
    
    
    register_file top_rf(
        .clk(top_clk),
        .rf_ld_en(top_rf_ld_en),
        .rf_load(top_rf_load),
        .rf_ld_adrs(top_rf_ld_adrs),         
        .rf_am(top_rf_am),  //clk t2   
        .rf_AA(top_AA),     //clk t2
        .rf_AB1(top_AB1),   //clk t2       
        .rf_AB2(top_AB2),   //clk t2       
        .rf_AB3(top_AB3),   //clk t2       
        .rf_AB4(top_AB4),   //clk t2       
        .rf_rw(top_nx4_rf_rw),       //comes from IR4        
        .rf_DA(top_nx4_DA),       //comes from IR4
        .rf_OA(top_OA), 
        .rf_inRow(top_to_rf_in),    //comes from IR4
        .rf_OB1(top_OB1),          
        .rf_OB2(top_OB2),          
        .rf_OB3(top_OB3),          
        .rf_OB4(top_OB4)                   
    );
    //(t7)//////////////////////read output back to TB
    wire[3:0]   top_nx5_DA;
    wire [1:0]  top_nx5_wt_rd; //also used here to get proper read output to TB 
        assign top_TB_ret = ((top_nx5_wt_rd == 2'b11) ? top_OA : 16'dZ);
        assign top_ret_adrs = ((top_nx5_wt_rd == 2'b11) ? top_nx5_DA : 16'dZ);
        
        
    //(t2)//////////////////////Instruction Register 1
    
    wire[3:0]   top_nx1_DA;
                
    wire [1:0]  top_nx1_add_en,
                top_nx1_wt_rd;
    
    wire    //top_nx1_DMX,
            //top_nx1_MUXD,
            top_nx1_mm_en,
            top_nx1_rf_rw;
    
    i_reg top_IR1(
        .clk(top_clk),
        //.ir_inDMX(top_DMX),                          
        .ir_inmm_en(top_mm_en),                        
        .ir_inadd_en(top_add_en),                 
        //.ir_inMUXD(top_MUXD),                         
        .ir_inrw(top_rf_rw),
        .ir_inwt_rd(top_wt_rd),                           
        .ir_inDA(top_DA),      //this is correct
        //.ir_outDMX(top_nx1_DMX),                    
        .ir_outmm_en(top_nx1_mm_en),                  
        .ir_outadd_en(top_nx1_add_en),           
        //.ir_outMUXD(top_nx1_MUXD),                   
        .ir_outrw(top_nx1_rf_rw),
        .ir_outwt_rd(top_nx1_wt_rd),                     
        .ir_outDA(top_nx1_DA) 
    );
    
    
    
    //(t3)//////////////////////ABDMX
    
    reg    [15:0]  top_toMA_A, 
                    top_toMA_B,
                    top_toMM_A,
                    top_toMM_B1,
                    top_toMM_B2,
                    top_toMM_B3,
                    top_toMM_B4;
    always@(posedge top_clk)
    begin
        top_toMA_A <=  top_nx1_add_en ?  top_OA : 16'dZ;
        top_toMA_B <=  top_nx1_add_en ? top_OB1 : 16'dZ;
   
        top_toMM_A <=  top_nx1_mm_en ?  top_OA : 16'dZ;
        top_toMM_B1 <=  top_nx1_mm_en ? top_OB1 : 16'dZ;
        top_toMM_B2 <=  top_nx1_mm_en ? top_OB2 : 16'dZ;
        top_toMM_B3 <=  top_nx1_mm_en ? top_OB3 : 16'dZ;
        top_toMM_B4 <=  top_nx1_mm_en ? top_OB4 : 16'dZ;
    end
    
    //(t3)//////////////////////IR2
    wire[3:0]   top_nx2_DA;
                
    wire [1:0]  top_nx2_add_en,
                top_nx2_wt_rd;
    
    wire    //top_nx2_MUXD,
            top_nx2_mm_en,
            top_nx2_rf_rw;
    
    i_reg top_IR2(
        .clk(top_clk),                         
        .ir_inmm_en(top_nx1_mm_en),                        
        .ir_inadd_en(top_nx1_add_en),                 
        //.ir_inMUXD(top_nx1_MUXD),                         
        .ir_inrw(top_nx1_rf_rw),
        .ir_inwt_rd(top_nx1_wt_rd),                           
        .ir_inDA(top_nx1_DA),      //this is correct                    
        .ir_outmm_en(top_nx2_mm_en),                  
        .ir_outadd_en(top_nx2_add_en),           
        //.ir_outMUXD(top_nx2_MUXD),                   
        .ir_outrw(top_nx2_rf_rw),
        .ir_outwt_rd(top_nx2_wt_rd),                     
        .ir_outDA(top_nx2_DA) 
    );
    //(t4)//////////////////////Matrix Adder
        wire [15:0] top_MA_ToMUXD;
        wire top_OF_ma;
    mat_add top_ma(
        .clk(top_clk),               
        .ma_add_en(top_nx2_wt_rd),   //was plugged in to top_nx2_add_en trying wt_rd for simplicity
        .ma_A(top_toMA_A),       
        .ma_B(top_toMA_B),       
        .ma_S(top_MA_ToMUXD),  
        .ma_OF(top_OF_ma) 
    );
     
    //(t4)//////////////////////Matrix Multiplier
        wire [15:0] top_MM_ToMUXD;
        wire top_OF_mm;
        
        matrix_multi top_mm (
        .clk(top_clk), 
        .mm_en(top_nx2_mm_en),                      
        .mm_A (top_toMM_A),     
        .mm_B1(top_toMM_B1),                         
        .mm_B2(top_toMM_B2),                         
        .mm_B3(top_toMM_B3),                         
        .mm_B4(top_toMM_B4),                         
        .mm_C(top_MM_ToMUXD),
        .mm_OF(top_OF_mm)
        );                       
    
    //(t4)//////////////////////IR3
    wire[3:0]   top_nx3_DA;
                
    wire [1:0]  top_nx3_wt_rd;
    
    wire    //top_nx3_MUXD,
            top_nx3_rf_rw;
    
    i_reg top_IR3(
        .clk(top_clk),                                         
        //.ir_inMUXD(top_nx2_MUXD),                         
        .ir_inrw(top_nx2_rf_rw),
        .ir_inwt_rd(top_nx2_wt_rd),                           
        .ir_inDA(top_nx2_DA),                
        //.ir_outMUXD(top_nx3_MUXD),                   
        .ir_outrw(top_nx3_rf_rw),
        .ir_outwt_rd(top_nx3_wt_rd),                     
        .ir_outDA(top_nx3_DA)
        );
             
    //(t5)//////////////////////MUXD
        
    always@(posedge top_clk) 
       begin
            case(top_nx3_wt_rd)   //ADD MLT MV or WT_RD?
                `ADD: top_to_rf_in <= top_MA_ToMUXD;
                `MLT: top_to_rf_in <= top_MM_ToMUXD;
                `MV: top_to_rf_in <= top_MA_ToMUXD;
                default: top_to_rf_in <= 16'bZ;
            endcase
       end
    //(t5)//////////////////////IR4
    wire [1:0]  top_nx4_wt_rd;
    
    i_reg top_IR4(
        .clk(top_clk),                                                                 
        .ir_inrw(top_nx3_rf_rw),                         
        .ir_inDA(top_nx3_DA),
        .ir_inwt_rd(top_nx3_wt_rd),                           
        .ir_outrw(top_nx4_rf_rw),                     
        .ir_outDA(top_nx4_DA),
        .ir_outwt_rd(top_nx4_wt_rd)
        );
        
    //(t6)//////////////////////IR5 for pipelining into TB
    i_reg top_IR5(
        .clk(top_clk),                                                                 
        .ir_inwt_rd(top_nx4_wt_rd),
        .ir_inDA(top_nx4_DA),                           
        .ir_outwt_rd(top_nx5_wt_rd),
        .ir_outDA(top_nx5_DA)
        );    
    
        
endmodule

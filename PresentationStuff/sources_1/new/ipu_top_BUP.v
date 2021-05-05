`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/29/2021
// Module Name: ipu_top
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module ipu_top(
    input top_rst,
    input top_im_ld_en,
    input top_rf_ld_en,
    input [15:0] top_rf_load,
    input [3:0] top_rf_ld_adrs,
    input [25:0] top_im_instLoad,
    input top_clk,
    output top_mm_OF,
    output reg [15:0] top_TB_ret,
    output reg [3:0] top_ret_adrs
    );
    
    
    
    parameter TOP_BIT_WIDTH = 4;  //todo: parametrize the register file (keep this at 4)
    //parameter TOP_SIG_WIDTH = TOP_BIT_WIDTH + 5;
    
    wire top_cSig_DMX,
        top_cSig_mm_en,
        top_cSig_MUXD,
        top_cSig_rf_rw;
    wire [1:0] top_cSig_add_en;
    wire [TOP_BIT_WIDTH-1 :0] 
        top_cSig_DA, 
        top_cSig_AA, 
        top_cSig_AB1, 
        top_cSig_AB2,
        top_cSig_AB3, 
        top_cSig_AB4;
    
    
    
/*    
    i_reg #(.IN_MSB(9), .OUT_MSB(1)) IR1();    //demultiplexers
    i_reg #(.IN_MSB(7), .OUT_MSB(1)) IR2();     //enables
    i_reg #(.IN_MSB(5), .OUT_MSB(0)) IR3();     //multiplexer
    i_reg #(.IN_MSB(4), .OUT_MSB(4)) IR4();       //writeback
*/  
    
    wire inx1_cSig_DMX,
        inx1_cSig_mm_en,
        inx1_cSig_MUXD,
        inx1_cSig_rf_rw;
    wire [TOP_BIT_WIDTH-1 :0] inx1_cSig_DA;
    wire [1:0] inx1_cSig_add_en;
     
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR1(      //demuxes  
        .clk(top_clk),
        .ir_inDMX(top_cSig_DMX),   
        .ir_inmm_en(top_cSig_mm_en),  
        .ir_inadd_en(top_cSig_add_en), 
        .ir_inMUXD(top_cSig_MUXD),   
        .ir_inrw(top_cSig_rf_rw),     
        .ir_inDA(top_cSig_DA),
        .ir_outDMX(inx1_cSig_DMX),      
        .ir_outmm_en(inx1_cSig_mm_en),  
        .ir_outadd_en(inx1_cSig_add_en), 
        .ir_outMUXD(inx1_cSig_MUXD),   
        .ir_outrw(inx1_cSig_rf_rw),     
        .ir_outDA(inx1_cSig_DA));
          
    wire inx2_cSig_mm_en,
        inx2_cSig_MUXD,
        inx2_cSig_rf_rw;
    wire [TOP_BIT_WIDTH-1 :0] inx2_cSig_DA;
    wire [1:0] inx2_cSig_add_en;
    
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR2(      //enables      
        .clk(top_clk),
        .ir_inmm_en(inx1_cSig_mm_en),   
        .ir_inadd_en(inx1_cSig_add_en), 
        .ir_inMUXD(inx1_cSig_MUXD),     
        .ir_inrw(inx1_cSig_rf_rw),      
        .ir_inDA(inx1_cSig_DA),       
        .ir_outmm_en(inx2_cSig_mm_en),    //to mm_en 
        .ir_outadd_en(inx2_cSig_add_en),  //to_add_en 
        .ir_outMUXD(inx2_cSig_MUXD),       
        .ir_outrw(inx2_cSig_rf_rw),        
        .ir_outDA(inx2_cSig_DA));         
    
    wire inx3_cSig_MUXD,                   
        inx3_cSig_rf_rw;                  
    wire [TOP_BIT_WIDTH-1 :0] inx3_cSig_DA;       
    
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR3(      //muxd  
        .clk(top_clk),
        .ir_inMUXD(inx2_cSig_MUXD),  
        .ir_inrw(inx2_cSig_rf_rw),   
        .ir_inDA(inx2_cSig_DA),     
        .ir_outMUXD(inx3_cSig_MUXD), //to MUXD
        .ir_outrw(inx3_cSig_rf_rw),  
        .ir_outDA(inx3_cSig_DA));   
    
    wire inx4_cSig_rf_rw;                  
    wire [TOP_BIT_WIDTH-1 :0] inx4_cSig_DA;  
    i_reg #(.IR_BIT_WIDTH(TOP_BIT_WIDTH)) IR4(      //writeback     
        .clk(top_clk),
        .ir_inrw(inx3_cSig_rf_rw),   
        .ir_inDA(inx3_cSig_DA),  
        .ir_outrw(inx4_cSig_rf_rw),  
        .ir_outDA(inx4_cSig_DA));
    
    
    wire [25:0] top_iw;
    InstructionMemory top_im(  
        .im_ld_en(top_im_ld_en),
        .im_instLoad(top_im_instLoad),
        .clk(top_clk),             
        .im_rst(top_rst),             
        .im_IW(top_iw));                     
    

    //where wire [1:0] top_wt_rd; still lives
    wire [1:0] top_wt_rd;
    
    Decoder top_inDec(
        .IW(top_iw),        
        .clk(top_clk),              
        .DA(top_cSig_DA),    
        .AA(top_cSig_AA),    
        .AB1(top_cSig_AB1),   
        .AB2(top_cSig_AB2),   
        .AB3(top_cSig_AB3),   
        .AB4(top_cSig_AB4),   
        .DMX(top_cSig_DMX),         
        .mm_en(top_cSig_mm_en),       
        .add_en(top_cSig_add_en),
        .MUXD(top_cSig_MUXD),        
        .rf_rw(top_cSig_rf_rw),       
        .rf_am(top_cSig_rf_am),
        .dec_wt_rd(top_wt_rd)        
    );
    
    wire [15:0] 
    top_toDMX_A,
    top_toDMX_B1,
    top_toDMX_B2,
    top_toDMX_B3,
    top_toDMX_B4;
    
    reg [15:0] top_to_rf,  top_to_rf_t;
    
    reg [3:0] top_to_rf_DA;
    
    reg top_to_RW;
    
    always @(*)  // don't add posedge, it will mess with timing
    begin
        if(top_rf_ld_en) 
        begin
            top_to_rf_DA <= top_rf_ld_adrs;
            top_to_RW <= 1'b1;
        end
        else 
        begin
            top_to_rf_DA <= inx4_cSig_DA;
            top_to_RW <= inx4_cSig_rf_rw;
        end
    end
    
    
    register_file top_rf(
        .clk(top_clk), 
        .rf_rw(top_to_RW), 
        .rf_am(top_cSig_rf_am),
        .rf_inRow(top_to_rf), 
        .rf_AA(top_cSig_AA), 
        .rf_AB4(top_cSig_AB1), 
        .rf_AB3(top_cSig_AB2), 
        .rf_AB2(top_cSig_AB3), 
        .rf_AB1(top_cSig_AB4), 
        .DA(top_to_rf_DA ), 
        .rf_OA(top_toDMX_A), 
        .rf_OB4(top_toDMX_B4), 
        .rf_OB3(top_toDMX_B3), 
        .rf_OB2(top_toDMX_B2), 
        .rf_OB1(top_toDMX_B1)
        );
    
    reg [31:0] top_toAdder;
    reg [79:0] top_toMulti;
    
    always@(*)
    begin
    if(top_wt_rd == 2'b11)  //for testing only
       begin
            top_ret_adrs <= top_cSig_AA;
            top_TB_ret <= top_toDMX_A;
        end
        else 
        begin
            top_TB_ret <= 16'd0;
            top_ret_adrs <= 4'dZ;
        end
    end    
    
    
    //ADMX BDMX    inputs from IR1
    always@(posedge top_clk)
    begin
        if(inx1_cSig_DMX == 1)  //ABDMX
        begin 
            //values to adder 
            top_toAdder[31:16] <= top_toDMX_A; 
            top_toAdder[15:0] <= top_toDMX_B1;

        end    
        else
            top_toMulti[79:64] <= top_toDMX_A; 
            top_toMulti[63:48] <= top_toDMX_B1;
            top_toMulti[47:32] <= top_toDMX_B2; 
            top_toMulti[31:16] <= top_toDMX_B3;
            top_toMulti[15:0] <= top_toDMX_B4;
            //values to multiplier
    end
    wire [15:0] top_cFrom_mm, top_cFrom_ma;
    matrix_multi #(.MM_BIT_WIDTH(TOP_BIT_WIDTH)) top_mm(
        .clk(top_clk),
        .mm_en(inx2_cSig_mm_en),
        .mm_A(top_toMulti[79:64]),
        .mm_B1(top_toMulti[63:48]), 
        .mm_B2(top_toMulti[47:32]),
        .mm_B3(top_toMulti[31:16]),
        .mm_B4(top_toMulti[15:0]),
        .mm_C(top_cFrom_mm),
        .mm_OF(top_mm_OF)
        );
    
    mat_add top_ma (
        .clk(top_clk),
        .ma_add_en(inx2_cSig_add_en),
        .ma_A(top_toAdder[31:16]),
        .ma_B(top_toAdder[15:0]),
        .ma_S(top_cFrom_ma)
    );
    
    always@(posedge top_clk) //MUXD
    begin
        if (top_rf_ld_en) top_to_rf <= top_rf_load;
        else if(inx3_cSig_MUXD == 1) top_to_rf <= top_cFrom_ma;
        else top_to_rf <= top_cFrom_mm;

        
    end

endmodule

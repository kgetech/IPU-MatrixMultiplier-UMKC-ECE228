`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/30/2021
// Module Name: i_reg
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////

module i_reg 
//#(  parameter IN_MSB = 3,
//    parameter OUT_MSB = 3)
  #(  parameter IR_BIT_WIDTH = 4 )
(   input clk,
    //input [IN_MSB-1:0] ir_in,
    //output reg [IN_MSB - OUT_MSB:0] ir_nxt,
    //output reg [OUT_MSB:0] ir_out
    input ir_inDMX, 
    input ir_inmm_en, 
    input [1:0] ir_inadd_en, 
    input ir_inMUXD, 
    input ir_inrw, 
    input [IR_BIT_WIDTH - 1:0] ir_inDA,
    output reg ir_outDMX, 
    output reg ir_outmm_en, 
    output reg [1:0] ir_outadd_en, 
    output reg ir_outMUXD, 
    output reg ir_outrw,
    output reg [IR_BIT_WIDTH - 1:0] ir_outDA
    );

    always@(posedge clk) 
    begin
        /*ir_nxt <= ir_in[IN_MSB - (OUT_MSB):0]; //trim off the top
        ir_out <= ir_in[IN_MSB - 1:IN_MSB - OUT_MSB]; //send outputs
        */
       ir_outDMX   <=  ir_inDMX;    
       ir_outmm_en  <=  ir_inmm_en;   
       ir_outadd_en <=  ir_inadd_en;  
       ir_outMUXD   <=  ir_inMUXD;    
       ir_outrw     <=  ir_inrw;     
       ir_outDA     <=  ir_inDA;
    end
endmodule

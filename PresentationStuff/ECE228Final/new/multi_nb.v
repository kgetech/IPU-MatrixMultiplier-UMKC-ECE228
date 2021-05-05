`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/07/2021
// Module Name: multi_nb
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module multi_nb
    #(parameter MN_BIT_WIDTH=4)(
    input [MN_BIT_WIDTH-1:0] m_A, m_B,
    output reg [MN_BIT_WIDTH-1:0] m_P,
    output reg m_OF
    );
    
    
    wire [2*MN_BIT_WIDTH-1:0] m_PLb;
    //{2{1'b0}} => 2'b00 
    //T/F ? Dothis : dothat
    //also comment/uncomment these lines to change bit width//////////////////////////
    wire [2*MN_BIT_WIDTH-1:0] m_a0, m_a1, m_a2, m_a3/*, a4, a5, a6, a7*/;                      //
    assign m_a0 = {{MN_BIT_WIDTH{1'b0}}, (m_B[0]? m_A : {MN_BIT_WIDTH{1'b0}})};                 //
    assign m_a1 = {{(MN_BIT_WIDTH-1){1'b0}}, (m_B[1]? m_A : {MN_BIT_WIDTH{1'b0}}) ,1'd0};       //
    assign m_a2 = {{(MN_BIT_WIDTH-2){1'b0}}, (m_B[2]? m_A : {MN_BIT_WIDTH{1'b0}}),2'd0};        //
    assign m_a3 = {{(MN_BIT_WIDTH-3){1'b0}}, (m_B[3]? m_A : {MN_BIT_WIDTH{1'b0}}),3'd0};        //
    //assign a4 = {{(MN_BIT_WIDTH-4){1'b0}}, (m_B[4]? m_A : {MN_BIT_WIDTH{1'b0}}),4'd0};      //
    //assign a5 = {{(MN_BIT_WIDTH-5){1'b0}}, (m_B[5]? m_A : {MN_BIT_WIDTH{1'b0}}),5'd0};      //
    //assign a6 = {{(MN_BIT_WIDTH-6){1'b0}}, (m_B[6]? m_A : {MN_BIT_WIDTH{1'b0}}),6'd0};      //
    //assign a7 = {{(MN_BIT_WIDTH-7){1'b0}}, (m_B[7]? m_A : {MN_BIT_WIDTH{1'b0}}),7'd0};      //
    assign m_PLb = m_a0 + m_a1 + m_a2 + m_a3/* + a4 + a5 + a6 + a7*/;                         //
    //////////////////////////////////////////////////////////////////////////////////
    
    always@(*) 
    begin
        if(m_PLb > { {MN_BIT_WIDTH{1'b0}},{MN_BIT_WIDTH{1'b1}} })
        begin
            m_P <= m_PLb[MN_BIT_WIDTH-1:0];
            m_OF <= 1'b1;
        end
        else 
        begin
            m_P <= m_PLb[MN_BIT_WIDTH-1:0];
            m_OF <= 1'b0;
        end
    end
    
endmodule

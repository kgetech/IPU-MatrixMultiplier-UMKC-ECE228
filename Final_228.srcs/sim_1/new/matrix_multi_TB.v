`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/27/2021
// Module Name: FA_nb
// Project Name: register_TB
//////////////////////////////////////////////////////////////////////////////////


//TODO: Figure out disconnects in waveform analysis, and why B matrix is outputting strange values

module matrix_multi_TB;
    reg         tb_clk,                              
                tb_mm_en;                            
    reg [15:0]  tb_mm_A,        
                tb_mm_B1,                            
                tb_mm_B2,                            
                tb_mm_B3,                            
                tb_mm_B4;                            
    wire [15:0] tb_mm_C;   
    wire        tb_mm_OF;                          
                                         
    matrix_multi mm_DUT(
        .clk    (tb_clk   ), 
        .mm_en  (tb_mm_en ), 
        .mm_A   (tb_mm_A  ), 
        .mm_B1  (tb_mm_B1 ), 
        .mm_B2  (tb_mm_B2 ), 
        .mm_B3  (tb_mm_B3 ), 
        .mm_B4  (tb_mm_B4 ),
        .mm_C   (tb_mm_C  ),
        .mm_OF  (tb_mm_OF )
    );



    initial $timeformat(-9, 2, "ns", 10); //sets time format for $display of %t

    initial tb_clk <= 0;
    always #5 tb_clk = ~tb_clk;

    reg [4:0] i;
    initial 
    begin
        tb_mm_en <= 1'b1;
        for(i = 5'd0; i<5'd16; i = i+5'd1)
        begin
            tb_mm_A     <=  {4{2'd0,i[1:0]}};  
            tb_mm_B1    <=  {4'd1, 4'd0, 4'd0, 4'd0}; 
            tb_mm_B2    <=  {4'd0, 4'd1, 4'd0, 4'd0}; 
            tb_mm_B3    <=  {4'd0, 4'd0, 4'd1, 4'd0}; 
            tb_mm_B4    <=  {4'd0, 4'd0, 4'd0, 4'd1};
            #5;
            $display("[%d] [%d] [%d] [%d]", tb_mm_C[15:12], tb_mm_C[11:8], tb_mm_C[7:4], tb_mm_C[3:0]);
            #5;
        end
        #5;
        $display("[%d] [%d] [%d] [%d]", tb_mm_C[15:12], tb_mm_C[11:8], tb_mm_C[7:4], tb_mm_C[3:0]);
        #5;
        for(i = 5'd0; i<5'd16; i = i+5'd1)
        begin
            tb_mm_A     <=  {4{2'd0,i[1:0]}};  
            tb_mm_B1    <=  {4'd1, 4'd1, 4'd1, 4'd1}; 
            tb_mm_B2    <=  {4'd2, 4'd2, 4'd2, 4'd2}; 
            tb_mm_B3    <=  {4'd1, 4'd1, 4'd1, 4'd1}; 
            tb_mm_B4    <=  {4'd2, 4'd2, 4'd2, 4'd2};
            #5;
            $display("[%d] [%d] [%d] [%d]", tb_mm_C[15:12], tb_mm_C[11:8], tb_mm_C[7:4], tb_mm_C[3:0]);
            #5;
        end
        #5;
        $display("[%d] [%d] [%d] [%d]", tb_mm_C[15:12], tb_mm_C[11:8], tb_mm_C[7:4], tb_mm_C[3:0]);
        #5;
        $finish;
    end
endmodule

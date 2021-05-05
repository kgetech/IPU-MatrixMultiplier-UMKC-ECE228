`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 05/04/2021
// Module Name: ma_TB
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module ma_TB;
    reg             TB_clk;             
    reg     [1:0]   TB_ma_add_en; 
    reg     [15:0]  TB_ma_A,     
                    TB_ma_B;            
    wire    [15:0]  TB_ma_S;     
    wire            TB_ma_OF;            

    mat_add ma_DUT(                   
        .clk            (TB_clk       ),                
        .ma_add_en      (TB_ma_add_en ),    
        .ma_A           (TB_ma_A      ),        
        .ma_B           (TB_ma_B      ),        
        .ma_S           (TB_ma_S      ),   
        .ma_OF          (TB_ma_OF     )
      );                            
    
    always #5 TB_clk <= ~TB_clk;
    
    reg [4:0] i;
    
    initial
    begin
        TB_ma_add_en    <=  2'b00;
        TB_clk          <=  1'b0;
        
        for (i = 5'd0; i < 5'd16; i = i + 5'd1)
        begin
            TB_ma_A       <=    {4{i[3:0]}};
            TB_ma_B       <=    {4{4'd1}};
            #5;
            $display ("[%d] [%d] [%d] [%d]", TB_ma_S[15:12], TB_ma_S[11:8], TB_ma_S[7:4], TB_ma_S[3:0]);
            
        end
        $finish;
    end
    


endmodule

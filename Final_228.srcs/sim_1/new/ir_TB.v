`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/29/2021
// Module Name: ir_TB
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module ir_TB;
    reg             TB_clk;
    reg             TB_ir_inDMX; 
    reg             TB_ir_inmm_en;
    reg     [1:0]   TB_ir_inadd_en;
    reg             TB_ir_inMUXD;
    reg             TB_ir_inrw;
    reg     [1:0]   TB_ir_inwt_rd;
    reg     [3:0]   TB_ir_inDA;
    wire            TB_ir_outDMX;
    wire            TB_ir_outmm_en;
    wire    [1:0]   TB_ir_outadd_en;
    wire            TB_ir_outMUXD;
    wire            TB_ir_outrw;
    wire    [1:0]   TB_ir_outwt_rd;
    wire    [3:0]   TB_ir_outDA;
    
    always #5 TB_clk <= ~TB_clk;
    
    i_reg ir_DUT(
          .clk          (TB_clk          ), //pardon the space, discovered the column select, and now I will never code the same again.
          .ir_inDMX     (TB_ir_inDMX     ),
          .ir_inmm_en   (TB_ir_inmm_en   ),
          .ir_inadd_en  (TB_ir_inadd_en  ),
          .ir_inMUXD    (TB_ir_inMUXD    ),
          .ir_inrw      (TB_ir_inrw      ),
          .ir_inwt_rd   (TB_ir_inwt_rd   ),
          .ir_inDA      (TB_ir_inDA      ),
          .ir_outDMX    (TB_ir_outDMX    ),
          .ir_outmm_en  (TB_ir_outmm_en  ),
          .ir_outadd_en (TB_ir_outadd_en ),
          .ir_outMUXD   (TB_ir_outMUXD   ),
          .ir_outrw     (TB_ir_outrw     ),
          .ir_outwt_rd  (TB_ir_outwt_rd  ),
          .ir_outDA     (TB_ir_outDA     )
    );
    
    reg [4:0] i;
    initial
    begin
        TB_clk <= 0;
        for(i=5'd0; i<5'd8; i=i+5'b1)
        begin             
            TB_ir_inDMX     <= i[0];        
            TB_ir_inmm_en   <= i[0];      
            TB_ir_inadd_en  <= i[1:0];     
            TB_ir_inMUXD    <= i[0];       
            TB_ir_inrw      <= i[0];         
            TB_ir_inwt_rd   <= i[1:0];      
            TB_ir_inDA      <= i[3:0];
            #5;
            $display("[%b] [%b] [%b] [%b] [%b] [%b] [%b]",
                TB_ir_outDMX,    
                TB_ir_outmm_en,  
                TB_ir_outadd_en, 
                TB_ir_outMUXD,   
                TB_ir_outrw,     
                TB_ir_outwt_rd,  
                TB_ir_outDA,     
                TB_ir_outDA);
            #5;           
        end
        $finish;
    end
    
endmodule

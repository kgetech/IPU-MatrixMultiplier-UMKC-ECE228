`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City                                    
// Engineer: Kyle Goodman                                                         
// Create Date: 5/3/2021                                                        
// Module Name: inst_mem_TB                                                           
// Project Name: Final_228                                                        
//////////////////////////////////////////////////////////////////////////////////


module inst_mem_TB;

    reg TB_clk;
    reg TB_rst;
    reg TB_ld_en;
    reg [25:0] TB_instLoad;
    wire [25:0] TB_IW;
    
    InstructionMemory im_DUT(
        .clk(TB_clk), 
        .im_rst(TB_rst),
        .im_ld_en(TB_ld_en),        
        .im_instLoad(TB_instLoad),
        .im_IW(TB_IW)
    );
    
    reg [5:0] i;
    reg [7:0] j;
    
    initial TB_clk <= 1'b0;
    always #5 TB_clk <= ~TB_clk;
    
    initial 
    begin
        #5 TB_rst <= 1'b1;  //rst im_counter
        TB_ld_en <= 1'b1;   //enable loading mode 
        #5 TB_rst <= 1'b0;
        for(i = 6'd0; i < 6'd32; i = i + 6'd1)
        begin
            TB_instLoad <= {20'd0, i};
            #10;
        end
        TB_instLoad <= {26'd0}; //because the load keeps going
        #5 TB_rst <= 1'b1;  //rst im_counter
        #5 TB_rst <= 1'b0;
        #5 TB_ld_en <= 1'b0;   //disable loading mode 
        #5
        for(j = 8'd0; j < 8'd128; j = j + 8'd1)
        begin
            $display("%d", TB_IW);
            #10;
        end
        
    end
endmodule

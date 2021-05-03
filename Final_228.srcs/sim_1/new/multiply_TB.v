`timescale 1ns / 1ps

module multiply_TB;
    parameter TB_BIT_WIDTH=4;
    reg [TB_BIT_WIDTH-1:0] A_TB, B_TB;
    wire [TB_BIT_WIDTH-1:0] P_TB;
    wire OF_TB;
    
    multi_nb multinb_DUT(.A(A_TB), .B(B_TB), .P(P_TB), .OF(OF_TB));
    
    reg [2*TB_BIT_WIDTH:0] i;
    initial
    begin
        for (i = {2*TB_BIT_WIDTH+1{1'b0}}; i < {2*TB_BIT_WIDTH+1{1'b1}}; i = i + { {2*TB_BIT_WIDTH{1'b0}},1'b1 } )
        begin
            A_TB <= i[2*TB_BIT_WIDTH-1:TB_BIT_WIDTH];
            B_TB <= i[TB_BIT_WIDTH-1:0];
            #10;
            $display("%d * %d = %d | OF = %b", A_TB, B_TB, P_TB, OF_TB);
        end
        #5; 
        $finish;
    end
    
endmodule
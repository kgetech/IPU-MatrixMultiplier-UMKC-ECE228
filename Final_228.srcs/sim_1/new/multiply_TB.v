`timescale 1ns / 1ps

module multiply_TB;
    reg [3:0] A_TB, B_TB;
    wire [3:0] P_TB;
    wire OF_TB;
    
    multiply_4b multi4_DUT(.A(A_TB), .B(B_TB), .P(P_TB), .OF(OF_TB));
    
    reg [8:0] i;
    initial
    begin
        for (i = 9'd0; i < 9'd 256; i = i + 9'd1)
        begin
            A_TB <= i[7:4];
            B_TB <= i[3:0];
            #10;
            $display("%d * %d = %d | OF = %b", A_TB, B_TB, P_TB, OF_TB);
        end
        #5; 
        $finish;
    end
    
endmodule
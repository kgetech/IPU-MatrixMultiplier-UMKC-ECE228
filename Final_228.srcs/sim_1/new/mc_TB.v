`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/08/2021
// Module Name: mc_TB
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////
module mc_TB;
    parameter BIT_WIDTH=4; 
    reg [BIT_WIDTH-1:0] Ai_TB, Bi_TB, Ci_TB;
    reg ENM_TB, ENA_TB;
    reg CLK_TB;
    wire [BIT_WIDTH-1:0] Ao_TB, Bo_TB, Co_TB;
    wire OF_TB;
    
    initial CLK_TB <= 0;
    
    always #5 CLK_TB <= ~CLK_TB;
    
    mac_cell mc_DUT(.Ai(Ai_TB), .Bi(Bi_TB), .Ci(Ci_TB), .Ao(Ao_TB), .Bo(Bo_TB), .Co(Co_TB), .OF(OF_TB), .ENM(ENM_TB), .ENA(ENA_TB), .CLK(CLK_TB));
    reg [BIT_WIDTH:0] t;
    reg [BIT_WIDTH:0] i;
    initial
    begin
        $display("tCLK | Ai Bi Ci | Ao Bo Co | OF |");
        #7;
        Ci_TB <= 0;
        ENM_TB <= 0;
        ENA_TB <= 0;
        t <= {BIT_WIDTH{1'b0}};
        for(i = {BIT_WIDTH{1'b0}}; i < { 2'b11,{BIT_WIDTH-1{1'b0}} }; i = i + {{BIT_WIDTH{1'b0}}, 1'b1})
        begin
            Ai_TB <= i[BIT_WIDTH-1:BIT_WIDTH/2];
            Bi_TB <= i[BIT_WIDTH/2 -1:0];
            #5;
            $display("t%d | %d %d %d | %d %d %d | %b |", t, Ai_TB, Bi_TB, Ci_TB, Ao_TB, Bo_TB, Co_TB, OF_TB); //like printf() in the C programming language
            #5;
            t <= t + { {BIT_WIDTH-1{1'b0}}, 1'b1 };
        end
        $finish;
    end
endmodule

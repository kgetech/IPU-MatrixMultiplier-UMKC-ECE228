`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/07/2021
// Module Name: multi_nb
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module multi_nb
    #(parameter BIT_WIDTH=4)(
    input [BIT_WIDTH-1:0] A, B,
    output reg [BIT_WIDTH-1:0] P,
    output reg OF
    );
    
    
    //wire [2*BIT_WIDTH-1:0] PLb;
    
    
    //also comment/uncomment these lines to change bit width//////////////////////////
    //wire [2*BIT_WIDTH-1:0] a0, a1, a2, a3/*, a4, a5, a6, a7*/;                      //
    //assign a0 = {{BIT_WIDTH{1'b0}}, (B[0]? A : {BIT_WIDTH{1'b0}})};                 //
    //assign a1 = {{(BIT_WIDTH-1){1'b0}}, (B[1]? A : {BIT_WIDTH{1'b0}}) ,1'd0};       //
    //assign a2 = {{(BIT_WIDTH-2){1'b0}}, (B[2]? A : {BIT_WIDTH{1'b0}}),2'd0};        //
    //assign a3 = {{(BIT_WIDTH-3){1'b0}}, (B[3]? A : {BIT_WIDTH{1'b0}}),3'd0};        //
    //assign a4 = {{(BIT_WIDTH-4){1'b0}}, (B[4]? A : {BIT_WIDTH{1'b0}}),4'd0};      //
    //assign a5 = {{(BIT_WIDTH-5){1'b0}}, (B[5]? A : {BIT_WIDTH{1'b0}}),5'd0};      //
    //assign a6 = {{(BIT_WIDTH-6){1'b0}}, (B[6]? A : {BIT_WIDTH{1'b0}}),6'd0};      //
    //assign a7 = {{(BIT_WIDTH-7){1'b0}}, (B[7]? A : {BIT_WIDTH{1'b0}}),7'd0};      //
    //assign PLb = a0 + a1 + a2 + a3/* + a4 + a5 + a6 + a7*/;                         //
    //////////////////////////////////////////////////////////////////////////////////
    
    
    reg [31:0] i;
    reg [(2*BIT_WIDTH) - 1:0] part_sum, tmp_A;
    
    always@(*)
    begin
        part_sum <= {(2*BIT_WIDTH)-1{1'b0}};
        tmp_A <= {{BIT_WIDTH{1'b0}}, A};
        for(i = 0; i < BIT_WIDTH; i = i + 1)
        begin
            part_sum = part_sum + (B[i]? tmp_A : {BIT_WIDTH{1'b0}});
            tmp_A <= tmp_A << 1;
        end
        if(tmp_A > { {BIT_WIDTH{1'b0}},{BIT_WIDTH{1'b1}} })
        begin
            P <= tmp_A[BIT_WIDTH-1:0];
            OF <= 1'b1;
        end
        else 
        begin
            P <= tmp_A[BIT_WIDTH-1:0];
            OF <= 1'b0;
        end
    end
endmodule

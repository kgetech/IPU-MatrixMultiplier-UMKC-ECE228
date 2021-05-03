`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/07/2021 03:00:41 AM
// Module Name: multiply_4b
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////


module multiply_4b(
    input [3:0] A,
    input [3:0] B,
    output reg [3:0] P,
    output reg OF
    );
    
    wire [7:0] a0, a1, a2, a3;
    wire [7:0] P8b;
    
    assign a0 = {4'b0000, A[3] & B[0], A[2] & B[0], A[1] & B[0], A[0] & B[0]};
    assign a1 = {3'b000, A[3] & B[1], A[2] & B[1], A[1] & B[1], A[0] & B[1],1'b0};
    assign a2 = {2'b00, A[3] & B[2], A[2] & B[2], A[1] & B[2], A[0] & B[2],2'b00};
    assign a3 = {1'b0, A[3] & B[3], A[2] & B[3], A[1] & B[3], A[0]& B[3],3'b000};
    
    assign P8b = a0 + a1 + a2 + a3;
    
    always@(*) 
    begin
        if(P8b > 8'b00001111)
        begin
            P <= P8b[3:0];
            OF <= 1'b1;
        end
        else 
        begin
            P <= P8b[3:0];
            OF <= 1'b0;
        end
    end
    
endmodule

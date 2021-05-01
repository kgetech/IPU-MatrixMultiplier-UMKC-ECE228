`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/27/2021
// Module Name: FA_nb
// Project Name: register_TB
//////////////////////////////////////////////////////////////////////////////////


//TODO: Figure out disconnects in waveform analysis, and why B matrix is outputting strange values

module register_TB;
    reg tb_clk, tb_rw, tb_am;
    reg [15:0] tb_inRow;
    reg [3:0] tb_AA, tb_DA;
    reg [15:0] tb_AB;
    wire [15:0] tb_OA; 
    wire [63:0] tb_OB;

    register_file rf_DUT(
        .clk(tb_clk), 
        .rf_rw(tb_rw), 
        .rf_am(tb_am),
        .rf_inRow(tb_inRow), 
        .rf_AA(tb_AA), 
        .rf_AB4(tb_AB[3:0]), 
        .rf_AB3(tb_AB[7:4]), 
        .rf_AB2(tb_AB[11:8]), 
        .rf_AB1(tb_AB[15:12]), 
        .DA(tb_DA), 
        .rf_OA(tb_OA), 
        .rf_OB4(tb_OB[15:0]), 
        .rf_OB3(tb_OB[31:16]), 
        .rf_OB2(tb_OB[47:32]), 
        .rf_OB1(tb_OB[63:48])
        );
    initial $timeformat(-9, 2, "ns", 10); //sets time format for $display of %t

    initial tb_clk <= 0;
    always #5 tb_clk = ~tb_clk;

    reg [4:0] i;
    initial 
    begin
    for (i = 5'd0; i <5'd16; i = i+5'd1)  //this loop increments through the destination addresses
        begin
            tb_DA <= i[3:0];
            #3;
            //$display("| t = %t | i == %d : %b | DA: %b", $realtime, i, i, tb_DA);
            #7;
        end
    end 
    
    reg [3:0] j;
    reg [3:0] k;
    initial
    begin
        tb_am <= 0;  //set to default state, doesn't matter right now
        tb_rw <= 1;  //set to write state
        #3; //wait for signals to propagate
        tb_inRow <= {4'd1,4'd0,4'd0,4'd0}; //send 1 row of a matrix to address 0 per the for loop
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd0,4'd1,4'd0,4'd0};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd0,4'd0,4'd1,4'd0};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd0,4'd0,4'd0,4'd1};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd1,4'd2,4'd3,4'd4};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd5,4'd6,4'd7,4'd8};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd9,4'd10,4'd11,4'd12};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd13,4'd14,4'd15,4'd0};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd1,4'd1,4'd1,4'd1}; //send 1 row of a matrix to address 0 per the for loop
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd2,4'd2,4'd2,4'd2};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd3,4'd3,4'd3,4'd3};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd4,4'd4,4'd4,4'd4};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd1,4'd2,4'd3,4'd4}; //send 1 row of a matrix to address 0 per the for loop
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd1,4'd2,4'd3,4'd4};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd1,4'd2,4'd3,4'd4};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_inRow <= {4'd1,4'd2,4'd3,4'd4};
        #7;
        $display("Input Value: %d %d %d %d", tb_inRow[15:12], tb_inRow[11:8], tb_inRow[7:4], tb_inRow[3:0]);
        #3;
        tb_am <= 1;
        tb_rw <= 0;
        #7
        for (k = 4'd1; k < 4'd4; k = k + 4'd1)
        begin
            tb_AB <= {k*4'd4, k*4'd4+4'd1, k*4'd4+4'd2, k*4'd4+4'd3}; // will pick the four rows of matrix B
            for (j = 0 ; j < 4'd4; j = j + 4'd1) 
            begin
                tb_AA <= (k-4'd1)*4'd4 + j; //will increment through the rows of matrix A
                #7;
                $display("| t=%t | Matrix A, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, j, tb_AA, tb_OA[15:12],tb_OA[11:8], tb_OA[7:4], tb_OA[3:0]);
                #3;
            end
            #5;
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d] ", $realtime, k-4'd1, k*4'd4, tb_OB[63:60],tb_OB[59:56], tb_OB[55:52], tb_OB[51:48]);
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, k, k*4'd4+4'd1, tb_OB[47:44],tb_OB[43:40], tb_OB[39:36], tb_OB[35:32]);
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, k+4'd1, k*4'd4+4'd2, tb_OB[31:28],tb_OB[27:24], tb_OB[23:20], tb_OB[19:16]);
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, k+4'd3, k*4'd4+4'd3, tb_OB[15:12],tb_OB[11:8], tb_OB[7:4], tb_OB[3:0]);
            #5;
        end
        #3;
        tb_am <= 0;
        tb_rw <= 0;
        #7;
        for (k = 4'd1; k < 4'd4; k = k + 4'd1)
        begin
            tb_AB <= {k*4'd4, k*4'd4+4'd1, k*4'd4+4'd2, k*4'd4+4'd3}; // will pick the four rows of matrix B
            for (j = 0 ; j < 4'd4; j = j + 4'd1) 
            begin
                tb_AA <= (k-4'd1)*4'd4 + j; //will increment through the rows of matrix A
                #7;
                $display("| t=%t | Matrix A, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, j, tb_AA, tb_OA[15:12],tb_OA[11:8], tb_OA[7:4], tb_OA[3:0]);
                #3;
            end
            #5;
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d] ", $realtime, k-4'd1, k*4'd4, tb_OB[63:60],tb_OB[59:56], tb_OB[55:52], tb_OB[51:48]);
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, k, k*4'd4+4'd1, tb_OB[47:44],tb_OB[43:40], tb_OB[39:36], tb_OB[35:32]);
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, k+4'd1, k*4'd4+4'd2, tb_OB[31:28],tb_OB[27:24], tb_OB[23:20], tb_OB[19:16]);
            $display("| t=%t | Matrix B, Row %d | Adrs 4'b%b: [%d %d %d %d]", $realtime, k+4'd3, k*4'd4+4'd3, tb_OB[15:12],tb_OB[11:8], tb_OB[7:4], tb_OB[3:0]);
            #5;
        end
    end
endmodule

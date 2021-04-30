`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/27/2021
// Module Name: register_file
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////
module register_file(
        input clk, rf_rw, rf_am,  //rf_am is to set to add-mode when rf_am == 1, this allows row outputs from B when enabled, for addition
        input [15:0] rf_inRow,
        input [3:0] rf_AA, rf_AB1, rf_AB2, rf_AB3, rf_AB4, DA,
        output reg [15:0] rf_OA, rf_OB1, rf_OB2, rf_OB3, rf_OB4
    );
    
    reg [15:0] rf [15:0]; 
    
 
    always@(posedge clk)
        begin
            if (rf_rw == 1) rf[DA][15:0] <= rf_inRow; //writing
            else rf[DA][15:0] <=  rf[DA][15:0];
                //begin 
                if (rf_am == 0) {rf_OA,rf_OB1,rf_OB2,rf_OB3,rf_OB4} <= { //output will always be in row form
                    rf[rf_AA][15:0],
                    rf[rf_AB1][15:12], //transpose column 1 into row 1
                    rf[rf_AB2][15:12],
                    rf[rf_AB3][15:12],
                    rf[rf_AB4][15:12],
                    rf[rf_AB1][11:8], //transpose column 2 into row 2
                    rf[rf_AB2][11:8],
                    rf[rf_AB3][11:8],
                    rf[rf_AB4][11:8],
                    rf[rf_AB1][7:4], //transpose column 3 into row 3
                    rf[rf_AB2][7:4],
                    rf[rf_AB3][7:4],
                    rf[rf_AB4][7:4],
                    rf[rf_AB1][3:0], //transpose column 4 of AB into row 4 of OB
                    rf[rf_AB2][3:0],
                    rf[rf_AB3][3:0],
                    rf[rf_AB4][3:0]
                    };
                else {rf_OA,rf_OB1,rf_OB2,rf_OB3,rf_OB4} <= {rf[rf_AA], rf[rf_AB1], rf[rf_AB2], rf[rf_AB3], rf[rf_AB4]};
               //end
        end

endmodule

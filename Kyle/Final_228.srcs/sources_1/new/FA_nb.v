`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/07/2021
// Module Name: FA_nb
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////
module FA_nb
    #(parameter FA_BIT_WIDTH=4)(
        //input Cin,
        input [FA_BIT_WIDTH-1:0] fa_A, fa_B,
        output [FA_BIT_WIDTH-1:0] fa_S,
        output fa_OF  //because we don't care about signs--yet
    );
    
    assign {fa_OF,fa_S} = fa_A + fa_B;
    
endmodule

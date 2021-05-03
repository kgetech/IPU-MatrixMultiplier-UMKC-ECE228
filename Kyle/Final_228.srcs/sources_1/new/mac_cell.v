`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/08/2021
// Module Name: mac_cell
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////
module mac_cell
    #(parameter BIT_WIDTH=4)(
    input [BIT_WIDTH-1:0] Ai,Bi,Ci,
    output reg [BIT_WIDTH-1:0] Ao,Bo,Co,
    output OF,  //angry overflow flag from multiplier or adder
    input ENM,  //enable or disable multiply    // this allows these features to be
    input ENA,  //enable or disable adder       // disabled, turning the cell into a delay
    input CLK
    );
    reg [BIT_WIDTH-1:0] At, Bt, Ct; //to hold values
    reg [BIT_WIDTH-1:0] prod; //to store product
    
    always@(posedge CLK)
    begin
        At <= Ai; //push those noob values into their prison cells 
        Bt <= Bi;
        Ct <= Ci;
    end
    
    wire AF, MF;
    assign OF = AF | MF;  //overflow handling
    
    wire [BIT_WIDTH-1:0] prodt, sumt;
    FA_nb mc_FA(.A(Ct), .B(prod),.G(sumt), .OF(AF)); //adder
    multi_nb mc_MY(.A(Ai), .B(Bi), .P(prodt), .OF(MF)); //multiplier
    
    always@(posedge CLK)
    begin
        if(ENM) prod <= {BIT_WIDTH{1'b0}};
        else prod <= prodt; //multiplied
    end
    
    always@(posedge CLK)
    begin
        Ao <= At;
        Bo <= Bt;
        if(ENA) Co <= Ct;
        else Co <= sumt; //multiplied and accumulated
    end
    
    
endmodule

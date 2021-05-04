`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Missouri-Kansas City
// Engineer: Kyle Goodman
// Create Date: 04/30/2021
// Module Name: ipu_TB
// Project Name: Final_228
//////////////////////////////////////////////////////////////////////////////////
`define ADD (2'b00)
`define MLT (2'b01)
`define MV (2'b10)
`define WT_RD (2'b11)

module ipu_TB;
    reg TB_top_rst;                      
    reg TB_im_ld_en;          
    reg TB_rf_ld_en;          
    reg [15:0] TB_rf_load;    
    reg [3:0] TB_rf_ld_adrs;
    reg [25:0] TB_im_instLoad;
    reg TB_clk;               
    wire TB_OF; 
    wire [15:0] TB_ret;
    wire [3:0]  TB_ret_adrs;

    initial $timeformat(-9, 2, "ns", 10); //sets time format for $display of %t
    
    initial TB_clk <= 0;
    
    always #5 TB_clk <= ~TB_clk;
    
    reg [4:0] i;
    
    initial 
    begin
    //#7;
    for (i = 5'd0; i <5'd16; i = i+5'd1)  //this loop increments through the destination addresses
        begin
            #3;
            TB_rf_ld_adrs <= i[3:0];
            //$display("| t = %t | i == %d : %b | DA: %b", $realtime, i, i, tb_DA);
            #7;
        end
    end 
      
    reg [4:0] j;
    reg [6:0] k;
    initial
    begin
        //load register file
        TB_im_ld_en <= 0;
        TB_rf_ld_en <= 1;
        #3; //wait for signals to propagate
        //Adrs 0
        TB_rf_load <= {4'd1,4'd0,4'd0,4'd0}; //send 1 row of a matrix to address 0 per the for loop
        #7;  
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;  //Adrs 1
        TB_rf_load <= {4'd0,4'd1,4'd0,4'd0};
        #7;  
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;  //Adrs 2
        TB_rf_load <= {4'd0,4'd0,4'd1,4'd0};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;  //Adrs 3
        TB_rf_load <= {4'd0,4'd0,4'd0,4'd1};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 4
        TB_rf_load <= {4'd1,4'd2,4'd3,4'd4};
        #7; 
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 5
        TB_rf_load <= {4'd5,4'd6,4'd7,4'd8};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 6
        TB_rf_load <= {4'd9,4'd10,4'd11,4'd12};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 7
        TB_rf_load <= {4'd13,4'd14,4'd15,4'd0};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 8
        TB_rf_load <= {4'd1,4'd1,4'd1,4'd1}; //send 1 row of a matrix to address 0 per the for loop
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 9
        TB_rf_load <= {4'd2,4'd2,4'd2,4'd2};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 10
        TB_rf_load <= {4'd3,4'd3,4'd3,4'd3};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 11
        TB_rf_load <= {4'd4,4'd4,4'd4,4'd4};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 12
        TB_rf_load <= {4'd1,4'd1,4'd1,4'd1}; //send 1 row of a matrix to address 0 per the for loop
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 13
        TB_rf_load <= {4'd1,4'd1,4'd1,4'd1};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 14
        TB_rf_load <= {4'd1,4'd1,4'd1,4'd1};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;//Adrs 15
        TB_rf_load <= {4'd1,4'd1,4'd1,4'd1};
        #7;
        $display("Input Value: %d %d %d %d", TB_rf_load[15:12], TB_rf_load[11:8], TB_rf_load[7:4], TB_rf_load[3:0]);
        #3;
        TB_rf_ld_en <= 0;
        #7
        
        //load instruction memory
        #5 TB_top_rst <= 1'b1;  //rst im_counter
        TB_im_ld_en <= 1'b1;   //enable loading mode 
        #5 TB_top_rst <= 1'b0;
        
        //start loading
        TB_im_instLoad <= {`MLT,4'd0,4'd0,4'd4,4'd5,4'd6,4'd7}; //multiply Row 0 of A into Columns of B, and writeback to RA 0
        #10;
        TB_im_instLoad <= {`MLT,4'd1,4'd1,4'd4,4'd5,4'd6,4'd7}; //same with Row 1
        #10;
        TB_im_instLoad <= {`MLT,4'd2,4'd2,4'd4,4'd5,4'd6,4'd7}; //same with Row 2
        #10;
        TB_im_instLoad <= {`MLT,4'd3,4'd3,4'd4,4'd5,4'd6,4'd7}; //same with Row 3
        #10; 
        TB_im_instLoad <= {`WT_RD,4'd0,4'd0,16'd0}; //wait read adrs 0
        #10;                                                       
        TB_im_instLoad <= {`WT_RD,4'd1,4'd1,16'd0}; //wait read adrs 1
        #10;                                                       
        TB_im_instLoad <= {`WT_RD,4'd2,4'd2,16'd0}; //wait read adrs 2
        #10;                                                       
        TB_im_instLoad <= {`WT_RD,4'd3,4'd3,16'd0}; //wait read adrs 3
        #10; 
        TB_im_instLoad <= {`ADD,4'd12,4'd12,4'd8,12'd0}; //add
        #10;                                                       
        TB_im_instLoad <= {`ADD,4'd13,4'd13,4'd9,12'd0}; //add
        #10;                                                       
        TB_im_instLoad <= {`ADD,4'd14,4'd14,4'd10,12'd0}; //add
        #10;                                                       
        TB_im_instLoad <= {`ADD,4'd15,4'd15,4'd11,12'd0}; //add
        #10; 
        TB_im_instLoad <= {`WT_RD,4'd12,4'd12,16'd0}; //wait read adrs 12
        #10;                                                       
        TB_im_instLoad <= {`WT_RD,4'd13,4'd13,16'd0}; //wait read adrs 13
        #10;                                                       
        TB_im_instLoad <= {`WT_RD,4'd14,4'd14,16'd0}; //wait read adrs 14
        #10;                                                       
        TB_im_instLoad <= {`WT_RD,4'd15,4'd15,16'd0}; //wait read adrs 15
        #10;
        for (j = 5'd0; j < 16; j = j+5'd1)
        begin

            TB_im_instLoad <= {`WT_RD,j[3:0],j[3:0],16'd0}; //read whole rf
            #10;
        end
        TB_im_instLoad <= {`MLT,4'd0,4'd0,4'd4,4'd5,4'd6,4'd7}; //repeat first instruction until after ld_en is shut off
        #5 TB_top_rst <= 1'b1;  //rst im_counter
        #5 TB_top_rst <= 1'b0;
        #5 TB_im_ld_en <= 1'b0;   //disable loading mode 
        #5
        #10;
        #40; //is huge deal, must wait for propagation
        #160
        for (k = 6'd0; k < 64; k = k + 6'd1)
        begin
            #8;
                $display("| t=%t | Read Attempt #%d | Adrs 4'b%b: [%d %d %d %d] | OF %b", 
                    $realtime,
                    k, 
                    TB_ret_adrs, 
                    TB_ret[15:12],
                    TB_ret[11:8], 
                    TB_ret[7:4], 
                    TB_ret[3:0], 
                    TB_OF);
            #2;
        end 
        $finish;
        end    
    ipu_top ipu_DUT(
       .top_rst(TB_top_rst),           
       .top_im_ld_en(TB_im_ld_en),          
       .top_rf_ld_en(TB_rf_ld_en),          
       .top_rf_load(TB_rf_load),
       .top_rf_ld_adrs(TB_rf_ld_adrs),    
       .top_im_instLoad(TB_im_instLoad),
       .top_clk(TB_clk),               
       .top_OF(TB_OF),  //this changed *notes for if you go back to v1            
       .top_TB_ret(TB_ret),  
       .top_ret_adrs(TB_ret_adrs)          
                  
    );
endmodule

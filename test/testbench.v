`timescale 1ns/1ps
`define PERIOD 10
module testbench();
 reg clk ;
 reg rst_n;
 wire [7:0] data_out;
 // Generate the clock
 initial begin
 forever
 #(`PERIOD/2) clk = ~clk;
 end
 // Adder Instance
 top system(
    .reset(rst_n),
    .clk(clk),
    .PCMout(data_out)
    );
 initial begin
 // Initialization
 rst_n = 1'b0;
 clk = 1'b0;
 // Reset the DUT
 #(`PERIOD*5)
 rst_n = 1'b1;
 #(`PERIOD*5)
 rst_n = 1'b0;
 #(`PERIOD*1000)
 $finish;
 end
endmodule
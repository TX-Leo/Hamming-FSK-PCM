//`timescale 1ns / 1ps

//module FreDivisions(clk, reset,
//                    clkout);
//input clk;
//input reset;
//output clkout;

//reg temp;
//assign clkout = temp;

//reg counterclkout;

//always @(posedge reset or posedge clk)
//begin
//    if(reset) begin
//		counterclkout <= 0;
//		temp <= 0;
//    end
//    else begin
//        if(counterclkout == 1) begin
//            counterclkout <= 0;
//			temp <= ~temp;
//        end
//        else begin
//            counterclkout<=counterclkout+1;
//        end
//    end
//end
//endmodule
`timescale 1ns / 1ps

module FreDivisions(
  input clk,
  input reset,
  output reg clkout
);

  reg [1:0] counterclkout;

  always @(posedge reset or posedge clk) begin
    if (reset) begin
      counterclkout <= 2'b00;
      clkout <= 1'b0;
    end
    else begin
      if (counterclkout == 2'b01) begin
        counterclkout <= 2'b00;
        clkout <= ~clkout;
      end
      else begin
        counterclkout <= counterclkout + 1;
      end
    end
  end

endmodule
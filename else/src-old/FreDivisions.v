`timescale 1ns / 1ps

module FreDivision(clk, reset,
                    clkout);
input clk;
input reset;
output clkout;

reg temp;
assign clkout = temp;

reg counterclkout;

always @(posedge reset or posedge clk)
begin
    if(reset) begin
		counterclkout <= 0;
    end
    else begin
        if(counterclkout == 1) begin
            counterclkout <= 0;
			temp <= ~temp;
        end
        else begin
            counterclkout<=counterclkout+1;
        end
    end
end
endmodule

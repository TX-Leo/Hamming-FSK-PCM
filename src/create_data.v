`timescale 1ns / 1ps

module create_data(
    input clk_character_rate,
    input reset,
    output [7:0] datain,
);

always @(posedge clk_character_rate or posedge reset)
begin
    if (reset) begin
        datain <= 8'b0; 
    end
    else begin
        datain <= 8'b01010101;
    end
end

endmodule

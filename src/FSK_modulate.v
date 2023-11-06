`timescale 1ns / 1ps

module FSK_modulate(
    input clk2,
    input [13:0] Hamcode,
    input reset,
    output reg fsk
);

reg [3:0] counter;
reg clk_send;
reg [3:0] i;
reg count;

always @(posedge clk2 or posedge reset)
begin
    if (reset) begin
        counter <= 4'b0;
        clk_send <= 1'b0;
        i <= 4'b0;
        count <= 4'b0;
    end
    else begin
        if (counter == 4'b1111) begin  //1bit的持续周期数(16个clk2)
            counter <= 4'b0;
            if (i == 4'd13) begin
                i <= 4'b0;
            end
            else begin
                i <= i + 1;
            end
        end
        else begin
            counter <= counter + 1;
        end
        if (Hamcode[i] == 1'b1) begin
            clk_send <= ~clk_send;
        end
        else begin
            if (count == 1'b0) begin
                count <= 1'b1;
                clk_send <= ~clk_send;
            end
            else begin
                count <= 1'b0;
            end
        end
    end
end

assign fsk = clk_send; // FSK 调制后的信号输出

endmodule

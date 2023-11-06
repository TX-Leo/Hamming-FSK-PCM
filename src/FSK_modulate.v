// FSK要求：信号为‘1’时，输出频率为f1，信号为‘0’时，输出频率为f2。
// 因此，我们利用一个2倍于f1的频率clk2来作为频率标准。当输入信号为‘1’时，我们将clk2两分频输出；而当为‘0’时，我们将clk2四分频输出。即：f1=7.8125MHz, f2=3.90625MHz。
// 于是，在一个比特周期（976.6kHz）中，‘0’信号有4个周期，‘1’信号有8个周期。
// 这样，在解调的时候，可以对半个比特周期中的接收信号的上升沿计数，这时3就成了判决门限。

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

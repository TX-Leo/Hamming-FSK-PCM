`timescale 1ns / 1ps

module Multi_fredivision(
    input clkIn,
    input reset,
    output reg clk_bitTransferRate, //�ַ�����
    output reg FSK_clk,
    output reg [3:0] counter2,
    output reg clkforAD,
    output reg [4:0] counter_serialAD, //32fre
    output reg [8:0] counterforAD,
    output reg clk_character_rate, //448fre
    output reg [7:0] counterAD //��������
);

always @(posedge clkIn or posedge reset)
begin
    if (reset) begin
        clk_bitTransferRate <= 1'b0;
        FSK_clk <= 1'b0;
        counter2 <= 4'b0;
        clkforAD <= 1'b0;
        counter_serialAD <= 5'b0;
        counterforAD <= 9'b0;
        counterAD <= 8'b0;
        clk_character_rate <= 1'b0;
    end
    else begin
        if (clkIn) begin
            FSK_clk <= ~FSK_clk; // 2��Ƶ�õ�Լ15.625MHz��FSK_clk
            
            if (counter_serialAD == 4'b1111) begin // 32��Ƶ�õ�Լ976.6kHz��clk_bitTransferRate
                counter_serialAD <= 5'b0;
                clk_bitTransferRate <= ~clk_bitTransferRate;
            end
            else begin
                counter_serialAD <= counter_serialAD + 1;
            end

            if (counterAD == 8'd223) begin // 32*14=448��Ƶ�õ�Լ69clk_character_ratez��clkAD
                counterAD <= 8'b0;
                clk_character_rate <= ~clk_character_rate;
            end
            else begin
                counterAD <= counterAD + 1;
            end

            if (counterforAD == 9'b10111) begin // 48��Ƶ�õ�651kHz��ADʱ���ź�
                counterforAD <= 9'b0;
                clkforAD <= ~clkforAD;
            end
            else begin
                counterforAD <= counterforAD + 1;
            end
        end
    end
end

endmodule

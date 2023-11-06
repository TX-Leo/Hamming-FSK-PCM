`timescale 1ns / 1ps

module Multi_fredivision(
    input clkIn,
    input reset,
    output reg clk_serialAD, //�ַ�����
    output reg clk2,
    output reg [3:0] counter2,
    output reg clkforAD,
    output reg [4:0] counter_serialAD, //32fre
    output reg [8:0] counterforAD,
    output reg clkAD, //448fre
    output reg [7:0] counterAD //��������
);

always @(posedge clkIn or posedge reset)
begin
    if (reset) begin
        clk_serialAD <= 1'b0;
        clk2 <= 1'b0;
        counter2 <= 4'b0;
        clkforAD <= 1'b0;
        counter_serialAD <= 5'b0;
        counterforAD <= 9'b0;
        counterAD <= 8'b0;
    end
    else begin
        if (clkIn) begin
            clk2 <= ~clk2; // 2��Ƶ�õ�Լ15.625MHz��clk2
            
            if (counter_serialAD == 4'b1111) begin // 32��Ƶ�õ�Լ976.6kHz��clk_serialAD
                counter_serialAD <= 5'b0;
                clk_serialAD <= ~clk_serialAD;
            end
            else begin
                counter_serialAD <= counter_serialAD + 1;
            end

            if (counterAD == 8'd223) begin // 32*14=448��Ƶ�õ�Լ69.75kHz��clkAD
                counterAD <= 8'b0;
                clkAD <= ~clkAD;
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

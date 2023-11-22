`timescale 1ns / 1ps

module Multi_fredivision(
    input clkIn,
    input reset,
    output reg clk_serialAD, //字符速率
    output reg clk2,
    output reg [3:0] counter2,
    output reg clkforAD,
    output reg [4:0] counter_serialAD, //32fre
    output reg [8:0] counterforAD,
    output reg clkAD, //448fre
    output reg [7:0] counterAD //比特速率
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
            clk2 <= ~clk2; // 2分频得到约15.625MHz的clk2
            
            if (counter_serialAD == 4'b1111) begin // 32分频得到约976.6kHz的clk_serialAD
                counter_serialAD <= 5'b0;
                clk_serialAD <= ~clk_serialAD;
            end
            else begin
                counter_serialAD <= counter_serialAD + 1;
            end

            if (counterAD == 8'd223) begin // 32*14=448分频得到约69.75kHz的clkAD
                counterAD <= 8'b0;
                clkAD <= ~clkAD;
            end
            else begin
                counterAD <= counterAD + 1;
            end

            if (counterforAD == 9'b10111) begin // 48分频得到651kHz的AD时钟信号
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

`timescale 1ns / 1ps

module PCM_encode(
    input clkAD,
    input reset,
    input [7:0] datain,
    output reg [7:0] PCMout
);
reg [12:0] readytopcm;

always @(posedge clkAD or posedge reset)
begin
    if (reset) begin
        readytopcm <= 13'b0; // 复位时，输出为0
        PCMout <= 8'b0;
    end
    else begin
        readytopcm[12:5] <= datain[7:0]; // 将读入的8位数据放到线性PCM的前8位
        readytopcm[4:0] <= 5'b00000; // 后5位附0
    end
end

always @(*)
begin
    case (readytopcm[11:5])
        7'b0000000: PCMout <= {readytopcm[12], 3'b000, readytopcm[4:1]};
        7'b0000001: PCMout <= {readytopcm[12], 3'b001, readytopcm[4:1]};
        7'b000001x: PCMout <= {readytopcm[12], 3'b010, readytopcm[5:2]};
        7'b00001xx: PCMout <= {readytopcm[12], 3'b011, readytopcm[6:3]};
        7'b0001xxx: PCMout <= {readytopcm[12], 3'b100, readytopcm[7:4]};
        7'b001xxxx: PCMout <= {readytopcm[12], 3'b101, readytopcm[8:5]};
        7'b01xxxxx: PCMout <= {readytopcm[12], 3'b110, readytopcm[9:6]};
        7'b1xxxxxx: PCMout <= {readytopcm[12], 3'b111, readytopcm[10:7]};
        default: PCMout <= 8'b0; // 默认情况
    endcase
end

endmodule



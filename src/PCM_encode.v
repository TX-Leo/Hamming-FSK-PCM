`timescale 1ns / 1ps

module PCM_encode(
    input clk_character_rate,
    input reset,
    input [7:0] datain,
    output reg [7:0] PCMout
);
reg [12:0] readytopcm;

always @(posedge clk_character_rate or posedge reset)
begin
    if (reset) begin
        readytopcm <= 13'b0; // ��λʱ�����Ϊ0
        PCMout <= 8'b0;
    end
    else begin
        readytopcm[12:5] <= datain[7:0]; // �������8λ���ݷŵ�����PCM��ǰ8λ
        readytopcm[4:0] <= 5'b00000; // ��5λ��0
    end
end

always @(*)
begin
    if(readytopcm[11:5] == 7'b0000000) begin
        PCMout <= {readytopcm[12], 3'b000, readytopcm[4:1]};
    end
    if(readytopcm[11:5] == 7'b0000001) begin
        PCMout <= {readytopcm[12], 3'b001, readytopcm[4:1]};
    end
    if(readytopcm[11:6] == 6'b000001) begin
        PCMout <= {readytopcm[12], 3'b010, readytopcm[5:2]};
    end
    if(readytopcm[11:7] == 5'b00001) begin
        PCMout <= {readytopcm[12], 3'b011, readytopcm[6:3]};
    end
    if(readytopcm[11:8] == 4'b0001) begin
        PCMout <= {readytopcm[12], 3'b100, readytopcm[7:4]};
    end
    if(readytopcm[11:9] == 3'b001) begin
        PCMout <= {readytopcm[12], 3'b101, readytopcm[8:5]};
    end
    if(readytopcm[11:10] == 2'b01) begin
        PCMout <= {readytopcm[12], 3'b110, readytopcm[9:6]};
    end
    if(readytopcm[11] == 1'b1) begin
        PCMout <= {readytopcm[12], 3'b111, readytopcm[10:7]};
    end
end

endmodule



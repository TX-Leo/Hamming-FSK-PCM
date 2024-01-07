// FSKҪ���ź�Ϊ��1��ʱ�����Ƶ��Ϊf1���ź�Ϊ��0��ʱ�����Ƶ��Ϊf2��
// ��ˣ��������FSK_clk2����f1��Ƶ��clk2����FSK_clk�׼���������ź�FSK_clk��ʱ�����ǽ�clk2����Ƶ���������Ϊ��0��ʱ�����ǽ�clk2�ķ�Ƶ���������f1=7.8125MHz, f2=3.90625MHz��
// ���ǣ���һ���������ڣ�976.6kHz���У���0���ź���4�����ڣ���1���ź���8�����ڡ�
// �������ڽ����ʱ�򣬿��Զ԰�����������еĽ����źŵ������ؼ�������ʱ3�ͳ����о����ޡ�

`timescale 1ns / 1ps

module FSK_modulate(
    input FSK_clk,
    input [13:0] Hamcode,
    input reset,
    output fsk
);

reg [3:0] counter;
reg clk_send;
reg [3:0] i;
reg count;

always @(posedge FSK_clk or posedge reset)
begin
    if (reset) begin
        counter <= 4'b0;
        clk_send <= 1'b0;
        i <= 4'b0;
        count <= 4'b0;
    end
    else begin
        if (counter == 4'b1111) begin  //1bit�ĳ����FSK_clk�(16��clk2)
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

assign fsk = clk_send; // FSK ���ƺ���ź����

endmodule

`timescale 1ns / 1ps

module FSK_demodulate(
    input reset,
    input fsk_signal, //fsk������ź�
    input clk_bitTransferRate,//bit����
    output reg [13:0] Hamcode
);

reg [13:0] dataout_recoding; // �������������
reg [3:0] serialSignalCount_ctr; // �Ѿ����ܵ�bit��
reg serialConversion_flag;  //0-�򿪴���ת��
reg [2:0] pulseCount_ctr; // FSK�źŵ����������

always @(posedge fsk_signal or posedge reset)
begin
    if (reset) begin
        serialSignalCount_ctr <= 4'd13; // ��ʼ�� serialSignalCount_ctr Ϊ13��pulseCount_ctr �� serialConversion_flag Ϊ 0
        serialConversion_flag <= 1'b0;
        pulseCount_ctr <= 3'b000;
    end
    else begin
        if (clk_bitTransferRate) begin // �clk_bitTransferRateAD �ĸߵ�ƽʱ���м���
            // serialConversion_flag = 1
            if (serialConversion_flag) begin
                // ����������13���Ͳ������
                if (serialSignalCount_ctr == 4'd13) begin
                    serialSignalCount_ctr <= 4'd0;
                end
                // ��������
                else begin
                    serialSignalCount_ctr <= serialSignalCount_ctr + 1;
                end
            end
            // �������
            pulseCount_ctr <= pulseCount_ctr + 1;
            serialConversion_flag <= 1'b0;
        end
        else begin // �ڵ͵�ƽʱֻ�����ж�
            if (pulseCount_ctr > 3) begin
                if (!serialConversion_flag) begin
                    dataout_recoding[serialSignalCount_ctr] <= 1'b1; // ����յ��Ĺ���������4���ж�Ϊ�յ�����1�ź�
                    serialConversion_flag <= 1'b1; // ��ʾ�յ��źţ���û������һ��9������˲��������
                end
            end
            else begin
                if (!serialConversion_flag) begin
                    dataout_recoding[serialSignalCount_ctr] <= 1'b0; // ����յ��Ĺ�����С��4���ж�Ϊ�յ�����0�ź�
                    serialConversion_flag <= 1'b1;
                end
            end
            pulseCount_ctr <= 3'b000;
        end
        // the component for recoding
        if (serialSignalCount_ctr == 4'd0) begin // ��������һ��13���źţ����в������
            Hamcode <= dataout_recoding[13:0]; 
        end
    end
end

endmodule
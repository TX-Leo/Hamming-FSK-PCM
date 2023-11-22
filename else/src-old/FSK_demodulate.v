module FSK_demodulate(
    input reset,
    input fsk_signal, //fsk������ź�
    input clk_serialAD,//bit����
    output reg [13:0] Hamcode
);

reg [13:0] dataout_recoding; // �������������
reg [3:0] k; // �Ѿ����ܵ�bit��
reg flag;  //0-�򿪴���ת��
reg [2:0] j; // FSK�źŵ����������

always @(posedge fsk_signal or posedge reset)
begin
    if (reset) begin
        k <= 4'd13; // ��ʼ�� k Ϊ13��j �� flag Ϊ 0
        flag <= 1'b0;
        j <= 3'b000;
    end
    else begin
        if (clk_serialAD) begin // �� clk_serialAD �ĸߵ�ƽʱ���м���
            // flag = 1
            if (flag) begin
                // ����������13���Ͳ������
                if (k == 3'd13) begin
                    k <= 3'b000;
                end
                // ��������
                else begin
                    k <= k + 1;
                end
            end
            // �������
            j <= j + 1;
            flag <= 1'b0;
        end
        else begin // �ڵ͵�ƽʱֻ�����ж�
            if (j > 3) begin
                if (!flag) begin
                    dataout_recoding[k] <= 1'b1; // ����յ��Ĺ���������4���ж�Ϊ�յ�����1�ź�
                    flag <= 1'b1; // ��ʾ�յ��źţ���û������һ��9������˲��������
                end
            end
            else begin
                if (!flag) begin
                    dataout_recoding[k] <= 1'b0; // ����յ��Ĺ�����С��4���ж�Ϊ�յ�����0�ź�
                    flag <= 1'b1;
                end
            end
            j <= 3'b000;
        end
        // the component for recoding
        if (k == 3'b000) begin // ��������һ��13���źţ����в������
            Hamcode <= dataout_recoding[13:0]; 
        end
    end
end

endmodule
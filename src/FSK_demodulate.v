module FSK_demodulate(
    input reset,
    input fsk_signal, //fsk待解调信号
    input clk_serialAD,//bit速率
    output reg [13:0] Hamcode
);

reg [13:0] dataout_recoding; // 并行输出缓冲器
reg [3:0] k; // 已经接受的bit数
reg flag;  //0-打开串并转换
reg [2:0] j; // FSK信号的脉冲计数器

always @(posedge fsk_signal or posedge reset)
begin
    if (reset) begin
        k <= 3'd13; // 初始化 k 为13，j 和 flag 为 0
        flag <= 1'b0;
        j <= 3'b000;
    end
    else begin
        if (clk_serialAD) begin // 在 clk_serialAD 的高电平时进行计数
            // flag = 1
            if (flag) begin
                // 缓冲器接受13个就并行输出
                if (k == 3'd13) begin
                    k <= 3'b000;
                end
                // 不到继续
                else begin
                    k <= k + 1;
                end
            end
            // 脉冲计数
            j <= j + 1;
            flag <= 1'b0;
        end
        else begin // 在低电平时只进行判断
            if (j > 3) begin
                if (!flag) begin
                    dataout_recoding[k] <= 1'b1; // 如果收到的过零数大于4则判断为收到的是1信号
                    flag <= 1'b1; // 表示收到信号，但没有收齐一组9个，因此不并行输出
                end
            end
            else begin
                if (!flag) begin
                    dataout_recoding[k] <= 1'b0; // 如果收到的过零数小于4则判断为收到的是0信号
                    flag <= 1'b1;
                end
            end
            j <= 3'b000;
        end
        // the component for recoding
        if (k == 3'b000) begin // 当收齐了一组13个信号，进行并行输出
            Hamcode <= dataout_recoding[13:0]; 
        end
    end
end

endmodule
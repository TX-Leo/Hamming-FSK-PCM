`timescale 1ns / 1ps

module top(
    input reset,
    input clk,
    output [7:0] PCMout
    //input [7:0] datain
);

wire clkIn;
wire clk_bitTransferRate;
wire FSK_clk;
wire [3:0] counter2;
wire clkforAD;
wire [4:0] counter_serialAD;
wire [8:0] counterforAD;
wire clk_character_rate;
wire [7:0] counterAD;
wire [7:0] PCMcode_encoded;
wire [13:0] ham_code_encoded;
wire fsk;
wire [13:0] ham_code_decoded;
wire [7:0] PCMcode_decoded;
wire [7:0] datain;

FreDivisions FreDivisions1(
    .clk(clk), 
    .reset(reset),
    .clkout(clkIn)
);
Multi_fredivision Multi_fredivision1(
    .clkIn(clkIn),
    .reset(reset),
    .clk_bitTransferRate(clk_bitTransferRate), 
    .FSK_clk(FSK_clk),
    .counter2(counter2),
    .clkforAD(clkforAD),
    .counter_serialAD(counter_serialAD),
    .counterforAD(counterforAD),
    .clk_character_rate(clk_character_rate), 
    .counterAD(counterAD)
);
create_data create_data1(
    .clk_character_rate(clk_character_rate),
    .reset(reset),
    .datain(datain)
);
PCM_encode PCM_encode1(
    .clk_character_rate(clk_character_rate),
    .reset(reset),
    .datain(datain),
    .PCMout(PCMcode_encoded)
);
Ham_encode Ham_encode1(
    .PCMcode(PCMcode_encoded),
    .ham_code(ham_code_encoded)
);
FSK_modulate FSK_modulate1(
    .FSK_clk(FSK_clk),
    .Hamcode(ham_code_encoded),
    .reset(reset),
    .fsk(fsk)
);
FSK_demodulate FSK_demodulate1(
    .reset(reset),
    .fsk_signal(fsk), 
    .clk_bitTransferRate(clk_bitTransferRate),
    .Hamcode(ham_code_decoded)
);
Ham_decode Ham_decode1(
    .ham_code(ham_code_decoded),
    .PCMcode(PCMcode_decoded)
);
PCM_decode PCM_decode1(
    .datain(PCMcode_decoded),
    .PCMout(PCMout)
);

endmodule

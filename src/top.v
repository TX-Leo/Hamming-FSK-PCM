`timescale 1ns / 1ps

module top(
    input reset,
    input clk,
    input [7:0] datain,
    output [7:0] PCMout
);

FreDivision(
    .clk(clk), 
    .reset(reset),
    .clkout(clkIn)
);
Multi_fredivision(
    .clkIn(clkIn),
    .reset(reset),
    .clk_serialAD(clk_serialAD), 
    .clk2(clk2),
    .counter2(counter2),
    .clkforAD(clkforAD),
    .counter_serialAD(counter_serialAD),
    .counterforAD(counterforAD),
    .clkAD(clkAD), 
    .counterAD(counterAD)
);
PCM_encode(
    .clkAD(clkAD),
    .reset(reset),
    .datain(datain),
    .PCMout(PCMcode_encoded)
);
Ham_encode(
    .PCMcode(PCMcode_encoded),
    .ham_code(ham_code_encoded)
);
FSK_modulate(
    .clk2(clk2),
    .Hamcode(ham_code_encoded),
    .reset(reset),
    .fsk(fsk)
);
FSK_demodulate(
    .reset(reset),
    .fsk_signal(fsk), 
    .clk_serialAD(clk_serialAD),
    .Hamcode(ham_code_decoded)
);
Ham_decode(
    .ham_code(ham_code_decoded),
    .PCMcode(PCMcode_decoded)
)
PCM_decode(
    .datain(PCMcode_decoded),
    .PCMout(PCMout)
);

endmodule

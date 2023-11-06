`timescale 1ns / 1ps

module Ham_encode(
    input [7:0] PCMcode,
    output reg [13:0] ham_code
);

always @(*)
begin
    ham_code[6:3] <= PCMcode[3:0];
    ham_code[2] <= PCMcode[1]^PCMcode[2]^PCMcode[3];
    ham_code[1] <= PCMcode[0]^PCMcode[2]^PCMcode[3];
    ham_code[0] <= PCMcode[1]^PCMcode[0]^PCMcode[3];
    
    ham_code[13:10] <= PCMcode[7:4];
    ham_code[9] <= PCMcode[5]^PCMcode[6]^PCMcode[7];
    ham_code[8] <= PCMcode[4]^PCMcode[6]^PCMcode[7];
    ham_code[7] <= PCMcode[5]^PCMcode[4]^PCMcode[7];
end

endmodule
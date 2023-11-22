//14bit hamming code ----decode---> 8 pcm code
`timescale 1ns / 1ps

module Ham_decode(
    input [13:0] ham_code,
    output reg [7:0] PCMcode
);
reg [2:0] s1;
reg [2:0] s2;

always @(*)
begin
    s1[2] <= ham_code[6]^ham_code[5]^ham_code[4]^ham_code[2];
    s1[1] <= ham_code[6]^ham_code[5]^ham_code[3]^ham_code[1];
    s1[0] <= ham_code[6]^ham_code[4]^ham_code[3]^ham_code[0];

    s2[2] <= ham_code[13]^ham_code[12]^ham_code[11]^ham_code[9];
    s2[1] <= ham_code[13]^ham_code[12]^ham_code[10]^ham_code[8];
    s2[0] <= ham_code[13]^ham_code[11]^ham_code[10]^ham_code[7];

    if (s1 == 3'b111) begin
        PCMcode[3:0] <= {~ham_code[6],ham_code[5:3]};
    end
    if (s1 == 3'b110) begin
        PCMcode[3:0] <= {ham_code[6],~ham_code[5],ham_code[4:3]};
    end
    if (s1 == 3'b101) begin
        PCMcode[3:0] <= {ham_code[6:5],~ham_code[4],ham_code[3]};
    end
    if (s1 == 3'b011) begin
        PCMcode[3:0] <= {ham_code[6:4],~ham_code[3]};
    end

    if (s2 == 3'b111) begin
        PCMcode[7:4] <= {~ham_code[13],ham_code[12:10]};
    end
    if (s2 == 3'b110) begin
        PCMcode[7:4] <= {ham_code[13],~ham_code[12],ham_code[11:10]};
    end
    if (s2 == 3'b101) begin
        PCMcode[7:4] <= {ham_code[13:12],~ham_code[11],ham_code[10]};
    end
    if (s2 == 3'b011) begin
        PCMcode[7:4] <= {ham_code[13:11],~ham_code[10]};
    end

    // no error
    if (s1 == 3'b000|| s1 == 3'b001|| s1 == 3'b010 || s1 == 3'b100) begin
        PCMcode[3:0] <= {ham_code[6:3]};
    end
    if (s2 == 3'b000|| s2 == 3'b001|| s2 == 3'b010 || s2 == 3'b100) begin
        PCMcode[7:4] <= {ham_code[13:10]};
    end


end


endmodule
`timescale 1ns / 1ps

module PCM_decode(
    input [7:0] datain,
    output [7:0] PCMout
);

reg [12:0]linearoutput;

always @(*)
begin
    linearoutput[12] <= datain[7];
    
    case (datain[6:4])
        3'b000:
            begin
                linearoutput[11:5] <= 7'b0000000;
                linearoutput[4:1] <= datain[3:0];
                linearoutput[0] <= 1'b1;
            end
        3'b001:
            begin
                linearoutput[11:5] <= 7'b0000001;
                linearoutput[4:1] <= datain[3:0];
                linearoutput[0] <= 1'b1;
            end
        3'b010:
            begin
                linearoutput[11:6] <= 6'b000001;
                linearoutput[5:2] <= datain[3:0];
                linearoutput[1:0] <= 2'b10;
            end
        3'b011:
            begin
                linearoutput[11:7] <= 5'b00001;
                linearoutput[6:3] <= datain[3:0];
                linearoutput[2:0] <= 3'b100;
            end
        3'b100:
            begin
                linearoutput[11:8] <= 4'b0001;
                linearoutput[7:4] <= datain[3:0];
                linearoutput[3:0] <= 4'b1000;
            end
        3'b101:
            begin
                linearoutput[11:9] <= 3'b001;
                linearoutput[8:5] <= datain[3:0];
                linearoutput[4:0] <= 5'b10000;
            end
        3'b110:
            begin
                linearoutput[11:10] <= 2'b01;
                linearoutput[9:6] <= datain[3:0];
                linearoutput[5:0] <= 6'b100000;
            end
        3'b111:
            begin
                linearoutput[11] <= 1'b1;
                linearoutput[10:7] <= datain[3:0];
                linearoutput[6:0] <= 7'b1000000;
            end
        default: null;
    endcase
end

assign PCMout[7:0]=linearoutput[12:5];

endmodule
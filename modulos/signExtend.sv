`include "defines.sv"

module signExtend (
    input logic [15:0] in,
    output logic [`WORD_LEN-1:0] out
);

    assign out = (in[15]) ? {16'h1111, in} : {16'h0000, in};

endmodule
module adder (
    input logic [`WORD_LEN-1:0] in1, in2,
    output logic [`WORD_LEN-1:0] out
);

    assign out = in1 + in2;

endmodule
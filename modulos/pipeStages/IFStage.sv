`include "defines.v"

module IFStage (
    input logic clk, rst, brTaken, freeze,
    input logic [`WORD_LEN-1:0] brOffset,
    output logic [`WORD_LEN-1:0] PC, instruction
);

    logic [`WORD_LEN-1:0] adderIn1, adderOut, brOffsetTimes4;

    mux #(.LENGTH(`WORD_LEN)) adderInput (
        .in1(32'd4),
        .in2(brOffsetTimes4),
        .sel(brTaken),
        .out(adderIn1)
    );

    adder add4 (
        .in1(adderIn1),
        .in2(PC),
        .out(adderOut)
    );

    register PCReg (
        .clk(clk),
        .rst(rst),
        .writeEn(~freeze),
        .regIn(adderOut),
        .regOut(PC)
    );

    instructionMem instructions (
        .rst(rst),
        .addr(PC),
        .instruction(instruction)
    );

    assign brOffsetTimes4 = brOffset << 2;

endmodule
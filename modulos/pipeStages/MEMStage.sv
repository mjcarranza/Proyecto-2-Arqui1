`include "defines.v"

module MEMStage (
    input logic clk, rst, MEM_R_EN, MEM_W_EN,
    input logic [`WORD_LEN-1:0] ALU_res, ST_value,
    output logic [`WORD_LEN-1:0] dataMem_out
);

    dataMem dataMem (
        .clk(clk),
        .rst(rst),
        .writeEn(MEM_W_EN),
        .readEn(MEM_R_EN),
        .address(ALU_res),
        .dataIn(ST_value),
        .dataOut(dataMem_out)
    );

endmodule
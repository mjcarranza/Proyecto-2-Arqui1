`include "defines.sv"

module MEM2WB (
    input logic clk, rst,
    input logic WB_EN_IN, MEM_R_EN_IN,
    input logic [`REG_FILE_ADDR_LEN-1:0] destIn,
    input logic [`WORD_LEN-1:0] ALUResIn, memReadValIn,


    output logic WB_EN, MEM_R_EN,
    output logic [`REG_FILE_ADDR_LEN-1:0] dest,
    output logic [`WORD_LEN-1:0] ALURes, memReadVal
);

    always_ff @(posedge clk) begin
        if (rst) begin
            {WB_EN, MEM_R_EN, dest, ALURes, memReadVal} <= '0;
        end else begin
            WB_EN <= WB_EN_IN;
            MEM_R_EN <= MEM_R_EN_IN;
            dest <= destIn;
            ALURes <= ALUResIn;
            memReadVal <= memReadValIn;
        end
    end

endmodule
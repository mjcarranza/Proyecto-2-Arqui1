`include "defines.sv"

module EXE2MEM (
    input logic clk, rst,
    input logic WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
    input logic [`WORD_LEN-1:0] PCIn, ALUResIn, STValIn,
    input logic [`REG_FILE_ADDR_LEN-1:0] destIn,


    output logic WB_EN, MEM_R_EN, MEM_W_EN,
    output logic [`WORD_LEN-1:0] PC, ALURes, STVal,
    output logic [`REG_FILE_ADDR_LEN-1:0] dest
);

    always_ff @(posedge clk) begin
        if (rst) begin
            {WB_EN, MEM_R_EN, MEM_W_EN, PC, ALURes, STVal, dest} <= '0;
        end else begin
            WB_EN <= WB_EN_IN;
            MEM_R_EN <= MEM_R_EN_IN;
            MEM_W_EN <= MEM_W_EN_IN;
            PC <= PCIn;
            ALURes <= ALUResIn;
            STVal <= STValIn;
            dest <= destIn;
        end
    end

endmodule
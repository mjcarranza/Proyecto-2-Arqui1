`include "defines.sv"

module regFile (
    input logic clk, rst, writeEn,
    input logic [`REG_FILE_ADDR_LEN-1:0] src1, src2, dest,
    input logic [`WORD_LEN-1:0] writeVal,
    output logic [`WORD_LEN-1:0] reg1, reg2
);

    localparam int REG_FILE_SIZE = `REG_FILE_SIZE;

    logic [`WORD_LEN-1:0] regMem [0:REG_FILE_SIZE-1];

    always_ff @(negedge clk) begin
        if (rst) begin
            for (int i = 0; i < `WORD_LEN; i++) begin
                regMem[i] <= '0;
            end
        end else if (writeEn) begin
            regMem[dest] <= writeVal;
        end
        regMem[0] <= '0; // Register 0 is always 0
    end

    assign reg1 = regMem[src1];
    assign reg2 = regMem[src2];

endmodule
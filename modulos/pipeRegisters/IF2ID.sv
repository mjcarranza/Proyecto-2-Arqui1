`include "defines.sv"

module IF2ID (
    input logic clk, rst, flush, freeze,
    input logic [`WORD_LEN-1:0] PCIn, instructionIn,
    output logic [`WORD_LEN-1:0] PC, instruction
);

    always_ff @(posedge clk) begin
        if (rst) begin
            PC <= '0;
            instruction <= '0;
        end else begin
            if (~freeze) begin
                if (flush) begin
                    instruction <= '0;
                    PC <= '0;
                end else begin
                    instruction <= instructionIn;
                    PC <= PCIn;
                end
            end
        end
    end

endmodule
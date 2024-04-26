`include "defines.sv"

module register (
    input logic clk, rst, writeEn,
    input logic [`WORD_LEN-1:0] regIn,
    output logic [`WORD_LEN-1:0] regOut
);

    always_ff @(posedge clk) begin
        if (rst) begin
            regOut <= '0;
        end else if (writeEn) begin
            regOut <= regIn;
        end
    end

endmodule
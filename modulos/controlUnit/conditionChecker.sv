`include "defines.sv"

module conditionChecker (
    input logic [`WORD_LEN-1:0] reg1, reg2,
    input logic [1:0] cuBranchComm,
    output logic brCond
);

    always_comb begin
        case (cuBranchComm)
            `COND_JUMP: brCond = 1'b1;
            `COND_BEZ: brCond = (reg1 == '0) ? 1'b1 : 1'b0;
            `COND_BNE: brCond = (reg1 != reg2) ? 1'b1 : 1'b0;
            default: brCond = 1'b0;
        endcase
    end

endmodule
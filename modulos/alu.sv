`include "defines.v"

module ALU (
    input logic [`WORD_LEN-1:0] val1, val2,
    input logic [`EXE_CMD_LEN-1:0] EXE_CMD,
    output logic [`WORD_LEN-1:0] aluOut
);

    always_comb begin
        case (EXE_CMD)
            `EXE_ADD: aluOut = val1 + val2;
            `EXE_SUB: aluOut = val1 - val2;
            `EXE_AND: aluOut = val1 & val2;
            `EXE_OR: aluOut = val1 | val2;
            `EXE_NOR: aluOut = ~(val1 | val2);
            `EXE_XOR: aluOut = val1 ^ val2;
            `EXE_SLA: aluOut = val1 << val2;
            `EXE_SLL: aluOut = val1 <<< val2;
            `EXE_SRA: aluOut = val1 >> val2;
            `EXE_SRL: aluOut = val1 >>> val2;
            default: aluOut = '0;
        endcase
    end

endmodule
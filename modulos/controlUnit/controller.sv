`include "defines.sv"

module controller (
    input logic hazard_detected,
    input logic [`OP_CODE_LEN-1:0] opCode,
    output logic branchEn,
    output logic [`EXE_CMD_LEN-1:0] EXE_CMD,
    output logic [1:0] Branch_command,
    output logic Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN
);

    always_comb begin
        if (!hazard_detected) begin
            {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} = '0;
            case (opCode)
                // operations writing to the register file
                `OP_ADD: begin EXE_CMD = `EXE_ADD; WB_EN = 1'b1; end
                `OP_SUB: begin EXE_CMD = `EXE_SUB; WB_EN = 1'b1; end
                `OP_AND: begin EXE_CMD = `EXE_AND; WB_EN = 1'b1; end
                `OP_OR: begin EXE_CMD = `EXE_OR; WB_EN = 1'b1; end
                `OP_NOR: begin EXE_CMD = `EXE_NOR; WB_EN = 1'b1; end
                `OP_XOR: begin EXE_CMD = `EXE_XOR; WB_EN = 1'b1; end
                `OP_SLA: begin EXE_CMD = `EXE_SLA; WB_EN = 1'b1; end
                `OP_SLL: begin EXE_CMD = `EXE_SLL; WB_EN = 1'b1; end
                `OP_SRA: begin EXE_CMD = `EXE_SRA; WB_EN = 1'b1; end
                `OP_SRL: begin EXE_CMD = `EXE_SRL; WB_EN = 1'b1; end

                // operations using an immediate value embedded in the instruction
                `OP_ADDI: begin EXE_CMD = `EXE_ADD; WB_EN = 1'b1; Is_Imm = 1'b1; end
                `OP_SUBI: begin EXE_CMD = `EXE_SUB; WB_EN = 1'b1; Is_Imm = 1'b1; end

                // memory operations
                `OP_LD: begin EXE_CMD = `EXE_ADD; WB_EN = 1'b1; Is_Imm = 1'b1; ST_or_BNE = 1'b1; MEM_R_EN = 1'b1; end
                `OP_ST: begin EXE_CMD = `EXE_ADD; Is_Imm = 1'b1; MEM_W_EN = 1'b1; ST_or_BNE = 1'b1; end

                // branch operations
                `OP_BEZ: begin EXE_CMD = `EXE_NO_OPERATION; Is_Imm = 1'b1; Branch_command = `COND_BEZ; branchEn = 1'b1; end
                `OP_BNE: begin EXE_CMD = `EXE_NO_OPERATION; Is_Imm = 1'b1; Branch_command = `COND_BNE; branchEn = 1'b1; ST_or_BNE = 1'b1; end
                `OP_JMP: begin EXE_CMD = `EXE_NO_OPERATION; Is_Imm = 1'b1; Branch_command = `COND_JUMP; branchEn = 1'b1; end
                default: {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} = '0;
            endcase
        end else if (hazard_detected) begin
            // preventing any writes to the register file or the memory
            {EXE_CMD, WB_EN, MEM_W_EN} = '0;
        end
    end

endmodule
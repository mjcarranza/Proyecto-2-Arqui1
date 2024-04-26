`include "defines.v"

module procesador (
    input logic CLOCK_50, rst, forward_EN
);
    logic clock = CLOCK_50;
    logic [`WORD_LEN-1:0] PC_IF, PC_ID, PC_EXE, PC_MEM;
    logic [`WORD_LEN-1:0] inst_IF, inst_ID;
    logic [`WORD_LEN-1:0] reg1_ID, reg2_ID, ST_value_EXE, ST_value_EXE2MEM, ST_value_MEM;
    logic [`WORD_LEN-1:0] val1_ID, val1_EXE;
    logic [`WORD_LEN-1:0] val2_ID, val2_EXE;
    logic [`WORD_LEN-1:0] ALURes_EXE, ALURes_MEM, ALURes_WB;
    logic [`WORD_LEN-1:0] dataMem_out_MEM, dataMem_out_WB;
    logic [`WORD_LEN-1:0] WB_result;
    logic [`REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM, dest_WB;
    logic [`REG_FILE_ADDR_LEN-1:0] src1_ID, src2_regFile_ID, src2_forw_ID, src2_forw_EXE, src1_forw_EXE;
    logic [`EXE_CMD_LEN-1:0] EXE_CMD_ID, EXE_CMD_EXE;
    logic [`FORW_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;
    logic [1:0] branch_comm;
    logic Br_Taken_ID, IF_Flush, Br_Taken_EXE;
    logic MEM_R_EN_ID, MEM_R_EN_EXE, MEM_R_EN_MEM, MEM_R_EN_WB;
    logic MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
    logic WB_EN_ID, WB_EN_EXE, WB_EN_MEM, WB_EN_WB;
    logic hazard_detected, is_imm, ST_or_BNE;

    regFile regFile (
        .clk(clock),
        .rst(rst),
        .src1(src1_ID),
        .src2(src2_regFile_ID),
        .dest(dest_WB),
        .writeVal(WB_result),
        .writeEn(WB_EN_WB),
        .reg1(reg1_ID),
        .reg2(reg2_ID)
    );

    hazard_detection hazard (
        .forward_EN(forward_EN),
        .is_imm(is_imm),
        .ST_or_BNE(ST_or_BNE),
        .src1_ID(src1_ID),
        .src2_ID(src2_regFile_ID),
        .dest_EXE(dest_EXE),
        .dest_MEM(dest_MEM),
        .WB_EN_EXE(WB_EN_EXE),
        .WB_EN_MEM(WB_EN_MEM),
        .MEM_R_EN_EXE(MEM_R_EN_EXE),
        .branch_comm(branch_comm),
        .hazard_detected(hazard_detected)
    );

    forwarding_EXE forwrding_EXE (
        .src1_EXE(src1_forw_EXE),
        .src2_EXE(src2_forw_EXE),
        .ST_src_EXE(dest_EXE),
        .dest_MEM(dest_MEM),
        .dest_WB(dest_WB),
        .WB_EN_MEM(WB_EN_MEM),
        .WB_EN_WB(WB_EN_WB),
        .val1_sel(val1_sel),
        .val2_sel(val2_sel),
        .ST_val_sel(ST_val_sel)
    );

    // PIPLINE STAGES
    IFStage IFStage (
        .clk(clock),
        .rst(rst),
        .freeze(hazard_detected),
        .brTaken(Br_Taken_ID),
        .brOffset(val2_ID),
        .instruction(inst_IF),
        .PC(PC_IF)
    );

    IDStage IDStage (
        .clk(clock),
        .rst(rst),
        .hazard_detected_in(hazard_detected),
        .instruction(inst_ID),
        .reg1(reg1_ID),
        .reg2(reg2_ID),
        .src1(src1_ID),
        .src2_reg_file(src2_regFile_ID),
        .src2_forw(src2_forw_ID),
        .val1(val1_ID),
        .val2(val2_ID),
        .brTaken(Br_Taken_ID),
        .EXE_CMD(EXE_CMD_ID),
        .MEM_R_EN(MEM_R_EN_ID),
        .MEM_W_EN(MEM_W_EN_ID),
        .WB_EN(WB_EN_ID),
        .is_imm_out(is_imm),
        .ST_or_BNE_out(ST_or_BNE),
        .branch_comm(branch_comm)
    );

    EXEStage EXEStage (
        .clk(clock),
        .EXE_CMD(EXE_CMD_EXE),
        .val1_sel(val1_sel),
        .val2_sel(val2_sel),
        .ST_val_sel(ST_val_sel),
        .val1(val1_EXE),
        .val2(val2_EXE),
        .ALU_res_MEM(ALURes_MEM),
        .result_WB(WB_result),
        .ST_value_in(ST_value_EXE),
        .ALUResult(ALURes_EXE),
        .ST_value_out(ST_value_EXE2MEM)
    );

    MEMStage MEMStage (
        .clk(clock),
        .rst(rst),
        .MEM_R_EN(MEM_R_EN_MEM),
        .MEM_W_EN(MEM_W_EN_MEM),
        .ALU_res(ALURes_MEM),
        .ST_value(ST_value_MEM),
        .dataMem_out(dataMem_out_MEM)
    );

    WBStage WBStage (
        .MEM_R_EN(MEM_R_EN_WB),
        .memData(dataMem_out_WB),
        .aluRes(ALURes_WB),
        .WB_res(WB_result)
    );

    // PIPLINE REGISTERS
    IF2ID IF2IDReg (
        .clk(clock),
        .rst(rst),
        .flush(IF_Flush),
        .freeze(hazard_detected),
        .PCIn(PC_IF),
        .instructionIn(inst_IF),
        .PC(PC_ID),
        .instruction(inst_ID)
    );

    ID2EXE ID2EXEReg (
        .clk(clock),
        .rst(rst),
        .destIn(inst_ID[25:21]),
        .src1_in
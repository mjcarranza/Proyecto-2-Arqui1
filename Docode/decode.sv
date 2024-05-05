
module decode( input logic clk, rst, regWriteWB,
					input logic [15:0] inst, PCPlus2, resultWB,
					input logic [3:0] RdestW,
					output logic [15:0] PCPlus2E, RD1E, RD2E, PCE, immExtE,
					output logic [3:0] RdE,
					output logic regWriteE, memWriteE, jumpE, branchE, aluSrcE,
					output logic [2:0] aluControlE,
					output logic [1:0] resultSrcE
					
					);

	logic [15:0] extended, dataDeco1, dataDeco2;
	logic regWriteD, memWriteD, jumpD, branchD, aluSrcD;
	logic [1:0] resultSrcD;
	logic [2:0] aluControlD;
	
	// instancia de extension de signo
	extend ext_inst(.Instr(inst[7:1]), .ExtImm(extended));
	
	// instancia de register file
	register_file regFile_inst(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW), 
										.WD3(resultWB),	
										.RD1(dataDeco1), 
										.RD2(dataDeco2)
										); 
									
	// instancia para la unidad de control
	Control_Unit control_inst( .operation(inst[15:12]),
										.imm(inst[0]),
										.regWrite(regWriteD), 
										.memWrite(memWriteD), 
										.jump(jumpD), 
										.branch(branchD), .aluSrc(aluSrcD), 
										.resultSrc(resultSrcD),
										.aluControl(aluControlD)
										);
	
	// instancia para el registro decode/execute
	ID_EXE_Reg decode(.clk(clk),
							.reset(rst),
							.pc_in(inst[11:0]),
							.pc_plus2_in(PCPlus2),
							.op1_in(dataDeco1),
							.op2_in(dataDeco2),
							.rd_in(inst[11:8]),
							.extend_in(extended),
							
							.regWrite_in(regWriteD), .memWrite_in(memWriteD), .jump_in(jumpD), 
							.branch_in(branchD), .aluSrc_in(aluSrcD),
							.resultSrc_in(resultSrcD),
							.aluControl_in(aluControlD),
	 
							.pc_out(PCE),
							.pc_plus2_out(PCPlus2E),
							.op1_out(RD1E),
							.op2_out(RD2E),
							.rd_out(RdE),
							.extend_out(immExtE),
							
							.regWrite_out(regWriteE), .memWrite_out(memWriteE), .jump_out(jumpE), 
							.branch_out(branchE), .aluSrc_out(aluSrcE),
							.resultSrc_out(resultSrcE),
							.aluControl_out(aluControlE)
							);

endmodule 
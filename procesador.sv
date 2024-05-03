module procesador(input logic clkFPGA, rst,
			output logic vgaclk, // 25.175 MHz VGA clock
			output logic hsync, vsync,
			output logic sync_b, blank_b, // To monitor & DAC
			output logic [7:0] r, g, b);

	logic [15:0] pc, pc_out, Inst, PCPlus2F, PCPlus2, PCTargetE, extended, extendedE, RD1E, RD2E;
	logic [15:0] pcStageIn, PCD, PCE, pcP2In, PCPlus2D, PCPlus2E, PCPlus2M, PCPlus2W, instDeco, dataDeco1, dataDeco2, resultWB;
	logic [15:0] aluResM, aluResW, writeDataM, readDataM, readDataW;
	logic PCSrcE, memWriteDeco, regWriteWB, regWriteM, regWriteDeco, memWriteM;
	logic jumpDeco, branchDeco, aluSrcDeco, resultSrcM;
	logic [1:0] resultSrcDeco, resultSrcW;
	logic [2:0] aluControlDeco;
	logic [3:0] RdestE, RdestW, RdestM;
 
	logic clk, clk_mem, clk_rom;
	
	// mod frecuencia para memoria
	new_clk #(.frec(16)) frec_clk (clk, clkFPGA);  // VERIFICAR SI NECESITO ESTO O ESTA BIEN CON EL DE LA FPGA

	// mux PC
	mux2_1 muxPC(.data0(PCPlus2F),
                .data1(PCTargetE),
                .select(PCSrcE),
                .result(pc)
                );
	
	// registro PC
	program_counter pc_inst(.clk(clk), .rst(rst), .d(pc), .q(pc_out));
	
	// sumar pc+4
	sumador sum_inst(.A(pc_out), .B(16'h2), .C(PCPlus2));

	// instancia de memoria de instrucciones
	IMem IMem_inst(.address(pc_out[7:0]), .clock(clk), .q(Inst));
	
	IF_ID_Reg fetch(.clk(clk), 
						.reset(rst), 
						.pc_in(pc_out), 
						.pc_plus2_in(PCPlus2), 
						.instruction_in(Inst), 
						.pc_out(PCD), 
						.pc_plus2_out(PCPlus2D), 
						.instruction_out(instDeco));
	
	// ------------------------------------- ciclo decode --------------------------------------- //
	
	// instancia de extension de signo
	extend ext_inst(.Instr(instDeco[7:1]), .ExtImm(extended));
	
	// instancia de register file
	register_file regFile_inst(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(instDeco[7:4]), 
										.A2(instDeco[3:0]), 
										.A3(RdestW), 
										.WD3(resultWB),	
										.RD1(dataDeco1), 
										.RD2(dataDeco2)
										); 
									
	// instancia para la unidad de control
	Control_Unit control_inst( .operation(instDeco[15:12]),
										.imm(instDeco[0]),
										.regWrite(regWriteDeco), 
										.memWrite(memWriteDeco), 
										.jump(jumpDeco), 
										.branch(branchDeco), .aluSrc(aluSrcDeco), 
										.resultSrc(resultSrcDeco),
										.aluControl(aluControlDeco)
										);
	
	// instancia para el registro decode/execute
	ID_EXE_Reg decode(.clk(clk),
							.reset(rst),
							.pc_in(PCD),
							.pc_plus2_in(PCPlus2D),
							.op1_in(dataDeco1),
							.op2_in(dataDeco2),
							.rd_in(instDeco[11:8]),
							.extend_in(extended),
							
							.regWrite_in(regWriteDeco), .memWrite_in(memWriteDeco), .jump_in(jumpDeco), 
							.branch_in(branchDeco), .aluSrc_in(aluSrcDeco),
							.resultSrc_in(resultSrcDeco),
							.aluControl_in(aluControlDeco),
	 
							.pc_out(PCE),
							.pc_plus2_out(PCPlus2E),
							.op1_out(RD1E),
							.op2_out(RD2E),
							.rd_out(RdestE),
							.extend_out(extendedE),
							
							.regWrite_out(), .memWrite_out(), .jump_out(), 
							.branch_out(), .aluSrc_out(),
							.resultSrc_out(),
							.aluControl_out()
							);
	// ------------------------------------- Etapa de ejecucion ---------------------------------- //
	// ------------------------------------- Etapa de memoria ------------------------------------ //
	
	// instancia de la memoria para datos
	DataMem dataMem_inst(.address(aluResM),
								.clock(clk),
								.data(writeDataM),
								.wren(memWriteM),
								.q(readDataM)
								);
								
	// instancia del registro de memoria
	MEM_WB_Reg memory(
						   .clk(clk),
							.reset(rst),
							
							.regWrite_in(regWriteM),
							.resultSrc_in(resultSrcM),
							.pc_plus2_in(PCPlus2M),
							.rd_in(RdestM),
							.aluRes_in(aluResM),
							.readData_in(readDataM),
							
							.regWrite_out(regWriteWB),
							.resultSrc_out(resultSrcW),
							.pc_plus2_out(PCPlus2W),
							.rd_out(RdestW),
							.aluRes_out(aluResW),
							.readData_out(readDataW)
							);
							
	// -------------------------------- Etapa de write back ------------------------------------ //
	
	// instancia de mux 3-1
	mux_WB mux3a1_inst(	.data0(aluResW),
								.data1(readDataW),
								.data2(PCPlus2W),
								.select(resultSrcW),
								.result(resultWB)
								);
	
			
endmodule 
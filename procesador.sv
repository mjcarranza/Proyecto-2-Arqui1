module procesador(input logic clk, rst,
			output logic vgaclk, // 25.175 MHz VGA clock
			output logic hsync, vsync,
			output logic sync_b, blank_b, // To monitor & DAC
			output logic [7:0] r, g, b);

	logic [15:0] pc, pc_out, Inst, PCPlus2F, extended, extendedE, RD1E, RD2E, srcBE;
	logic [15:0] pcStageIn, PCD, PCE, pcP2In, PCPlus2D, PCPlus2E, PCPlus2M, PCPlus2W, instDeco, dataDeco1, dataDeco2, resultWB;
	logic [15:0] aluResM, aluResE, aluResW, writeDataM, readDataM, readDataW, realPc;
	logic PCSrcE, memWriteDeco, memWriteE, regWriteWB, regWriteM, regWriteE, regWriteDeco, memWriteM;
	logic jumpDeco, jumpE, branchDeco, branchE, aluSrcDeco, aluSrcE, resultSrcM, zeroE, procesStop;
	logic [1:0] resultSrcDeco, resultSrcE, resultSrcW;
	logic [3:0] aluControlDeco, aluControlE;
	logic [3:0] RdestE, RdestW, RdestM;
	
	
	
	// --------------------------------------- VGA --------------------------------------------------//
	
	vga vga_inst(
				.clk(clk),
				.vgaclk(vgaclk),
				.hsync(hsync), 
				.vsync(vsync),
				.sync_b(sync_b), 
				.blank_b(blank_b),
				.r(r), 
				.g(g), 
				.b(b)
				);

	// --------------------------------------- ciclo fetch --------------------------------------------------//
	
	// mux PC
	mux2_1 muxPC(.data0(PCPlus2F),
                .data1(PCPlus2E),
                .select(PCSrcE),
                .result(pc)
                );
	
	// registro PC
	program_counter pc_inst(.clk(clk), .rst(rst), .d(pc), .stop(procesStop), .q(pc_out));
	
	// sumar pc+4
	sumador sum_inst(.A(pc_out), .B(16'h2), .C(PCPlus2F));

	// instancia de memoria de instrucciones
	IMem IMem_inst(.address(pc_out[7:0]), .clock(clk), .q(Inst));
	
	IF_ID_Reg fetch(.clk(clk), 
						.reset(rst), 
						.pc_plus2_in(PCPlus2F), 
						.instruction_in(Inst), 
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
										.branch(branchDeco), 
										.aluSrc(aluSrcDeco), 
										.resultSrc(resultSrcDeco),
										.aluControl(aluControlDeco),
										.stop(procesStop)
										);
										
	// instancia para el sll del pc
	shiftLPC(
				.pc(instDeco[11:0]),
            .realPC(realPc)
				);
	
	// instancia para el registro decode/execute
	ID_EXE_Reg decode(.clk(clk),
							.reset(rst),
							.pc_in(realPc),
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
							
							.regWrite_out(regWriteE), .memWrite_out(memWriteE), .jump_out(jumpE), 
							.branch_out(branchE), .aluSrc_out(aluSrcE),
							.resultSrc_out(resultSrcE),
							.aluControl_out(aluControlE)
							);
	// ------------------------------------- Etapa de ejecucion ---------------------------------- //
	
	
	// instancia mux
	mux_Exe muxExe_inst(.data0(RD2E),
							  .data1(extendedE),
							  .select(resultSrcE),
							  .result(srcBE)
							  );
	
	// instancia de la alu
	alu alu_inst(
					 .A(RD1E),
					 .B(srcBE),
					 .sel(aluControlE),
					 .alu_out(aluResE),
					 .zero(zeroE)
					);
					
	// instancia de compuerta 
	compuerta compuerta_inst(
							 .zeroE(zeroE), 
							 .jumpE(jumpE), 
							 .branchE(branchE),
							 .pcSrcE(PCSrcE) // salida
							);
							
	// instancia registro exe-mem
	EXE_MEM_Reg EMReg_inst(
							 .clk(clk),              	// Reloj del sistema
							 .reset(rst),            	// Reset asíncrono
							 
							 .regWrite_in(regWriteE), 
							 .memWrite_in(memWriteE),
							 .resultSrc_in(resultSrcE),
							 
							 .pc_plus2_in(PCPlus2E), // Valor de PC+4 de la etapa IF
							 .rd_in(RdestE),     	// Registro destino
							 .aluRes_in(aluResE),
							 .op2_in(RD2E),     	// Operando 2
							 
							 
							 .regWrite_out(regWriteM),
							 .resultSrc_out(resultSrcM),
							 .memWrite_out(memWriteM),
							 .pc_plus2_out(PCPlus2M),  // Valor de PC+4 almacenado
							 .rd_out(RdestM),     	// Registro destino
							 .aluRes_out(aluResM),
							 .op2_out(writeDataM)     	// Operando 2
							 					  
							);
	
	
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
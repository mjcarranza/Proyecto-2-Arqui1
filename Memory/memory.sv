

module memory( input logic clk, rst, regWriteM, memWriteM,
					input logic [15:0] aluResM, writeDataM, PCPlus2M,
					input logic [3:0] RdM,
					input logic [1:0] resultSrcM,
					output logic [15:0] PCPlus2W, aluResW, readDataW, writeDataW,
					output logic [3:0] RdW,
					output logic regWriteW,
					output logic [1:0] resultSrcW 
					
					);
					
					
	logic [15:0] readDataM;
	
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
							.rd_in(RdM),
							.aluRes_in(aluResM),
							.readData_in(readDataM),
							.writeDataM(writeDataM),
							
							.regWrite_out(regWriteW),
							.resultSrc_out(resultSrcW),
							.pc_plus2_out(PCPlus2W),
							.rd_out(RdW),
							.aluRes_out(aluResW),
							.readData_out(readDataW),
							.writeDataW(writeDataW)
							);
					
					
endmodule 
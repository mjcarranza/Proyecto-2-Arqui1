module fetch(input logic clk, rst, PCSrcE,
			input logic [15:0] PCTargetE, PCPlus2F,
			output logic [15:0] InstrD, PCPlus2D);
			
	logic [15:0] pc, pc_out, Inst, PCD, PCPlus2;
	
	// mux PC
	mux2_1 muxPC(.data0(PCPlus2F),
                .data1(PCTargetE),
                .select(PCSrcE),
                .result(pc)
                );
					 
	// registro PC
	program_counter pc_inst(.clk(clk), .rst(rst), .d(pc), .q(pc_out));
	
	// sumar pc+2
	sumador sum_inst(.A(pc_out), .B(16'h1), .C(PCPlus2));

	// instancia de memoria de instrucciones
	IMem IMem_inst(.address(pc_out[11:0]), .clock(clk), .q(Inst));
	
	IF_ID_Reg fetch(.clk(clk), 
						.reset(rst), 
						.pc_in(pc_out), 
						.pc_plus2_in(PCPlus2), 
						.instruction_in(Inst), 
						.pc_out(PCD), /// este no lo necesito
						.pc_plus2_out(PCPlus2D), 
						.instruction_out(InstrD)); 
endmodule 
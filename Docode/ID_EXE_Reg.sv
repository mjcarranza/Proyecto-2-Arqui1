module ID_EXE_Reg(
    input logic clk,              	// Reloj del sistema
    input logic reset,            	// Reset asíncrono
	 
    input logic [15:0] pc_in,     	// Valor de PC de la etapa IF
    input logic [15:0] pc_plus2_in, // Valor de PC+4 de la etapa IF
	 input logic [15:0] op1_in,     	// Operando 1
	 input logic [15:0] op2_in,     	// Operando 2
	 input logic [3:0] rd_in,     	// Registro destino
	 input logic [15:0] extend_in,   // Valor de PC de la etapa IF
	 
	 input regWrite_in, memWrite_in, jump_in, branch_in, aluSrc_in, // banderas de 1 bit
	 input [1:0] resultSrc_in, // bandera de 2 bits
	 input [2:0] aluControl_in,  // bandera de 3 bits
	 
	 // agregar aca las se;ales del control unit	 in/out
	 
    output logic [15:0] pc_out,        // Valor de PC almacenado
    output logic [15:0] pc_plus2_out,  // Valor de PC+4 almacenado
	 output logic [15:0] op1_out,     	// Operando 1
	 output logic [15:0] op2_out,     	// Operando 2
	 output logic [3:0] rd_out,     	// Registro destino
	 output logic [15:0] extend_out,    // Valor de PC de la etapa IF
	 
	 output regWrite_out, memWrite_out, jump_out, branch_out, aluSrc_out, // banderas de 1 bit
	 output [1:0] resultSrc_out, // bandera de 2 bits
	 output [2:0] aluControl_out  // bandera de 3 bits
	);

    // Define registros internos para almacenar los valores entre etapas
    logic [15:0] pc_reg;
    logic [15:0] pc_plus2_reg;
	 logic [3:0] rd_reg;
	 logic [15:0] op1_reg;
	 logic [15:0] op2_reg;
	 logic [15:0] ext_reg;
	 
	 // banderas
	 logic [1:0] resultSrc;
	 logic [2:0] aluControl;
	 logic regWrite, memWrite, jump, branch, aluSrc;
	 
	 

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
	 
        if (reset) begin					// Limpia los registros si la señal de reset está activa
            pc_reg <= 16'b0;
            pc_plus2_reg <= 16'b0;
				rd_reg <= 4'b0;
				ext_reg <= 16'b0;
				op1_reg <= 16'b0;
				op2_reg <= 16'b0;
				
				resultSrc <= 2'b0;
				aluControl <= 3'b0;
				regWrite <= 1'b0;
				memWrite <= 1'b0;
				jump <= 1'b0;
				branch <= 1'b0;
				aluSrc <= 1'b0;
				
        end else begin 		// Actualiza los registros
            pc_reg <= pc_in;
            pc_plus2_reg <= pc_plus2_in;
				rd_reg <= rd_in;
				ext_reg <= extend_in;
				op1_reg <= op1_in;
				op2_reg <= op2_in;
				
				resultSrc <= resultSrc_in;
				aluControl <= aluControl_in;
				regWrite <= regWrite_in;
				memWrite <= memWrite_in;
				jump <= jump_in;
				branch <= branch_in;
				aluSrc <= aluSrc_in;
				
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
    assign pc_out = pc_reg;
    assign pc_plus2_out = pc_plus2_reg;
	 assign rd_out = rd_reg;
	 assign op1_out = op1_reg;
	 assign op2_out = op2_reg;
	 assign extend_out = ext_reg;
	 
	 assign resultSrc_out = resultSrc;
	 assign aluControl_out = aluControl;
	 assign regWrite_out = regWrite;
	 assign memWrite_out =  memWrite;
	 assign jump_out = jump;
	 assign branch_out = branch;
	 assign aluSrc_out = aluSrc;

endmodule

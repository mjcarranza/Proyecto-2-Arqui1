module MEM_WB_Reg(

    input logic clk,              			// Reloj del sistema
    input logic reset,            			// Reset asíncrono
	 
	 input logic regWrite_in,
	 input logic [1:0]resultSrc_in,
    input logic [15:0] pc_plus2_in, 		// Valor de PC+4 de la etapa IF
	 input logic [3:0] rd_in,     			// Registro destino
	 input logic [15:0] aluRes_in,
	 input logic [15:0] readData_in,     	// Operando 2
	 
	 output logic regWrite_out,
	 output logic [1:0] resultSrc_out,
    output logic [15:0] pc_plus2_out,  	// Valor de PC+4 almacenado
	 output logic [3:0] rd_out,     			// Registro destino
	 output logic [15:0] aluRes_out,
	 output logic [15:0] readData_out     	// Operando 2
	  
);

    // Define registros internos para almacenar los valores entre etapas
	 logic regWrite_reg;
	 logic [1:0] resultSrc_reg;
    logic [15:0] pc_plus2_reg;
	 logic [3:0] rd_reg;
	 logic [15:0] aluRes_reg;
	 logic [15:0] readData_reg;
	 

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
	 
        if (reset) begin					// Limpia los registros si la señal de reset está activa
				regWrite_reg <= 1'b0;
				resultSrc_reg <= 1'b0;
            pc_plus2_reg <= 16'b0;
				rd_reg <= 4'b0;
				aluRes_reg <= 16'b0;
				readData_reg <= 16'b0;
				
				
        end else begin 		// Actualiza los registros
		  
				regWrite_reg <= regWrite_in;
				resultSrc_reg <= resultSrc_in;
            pc_plus2_reg <= pc_plus2_in;
				rd_reg <= rd_in;
				aluRes_reg <= aluRes_in;
				readData_reg <= readData_in;
				
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
	 assign regWrite_out = regWrite_reg;
	 assign resultSrc_out = resultSrc_reg;
    assign pc_plus2_out = pc_plus2_reg;
	 assign rd_out = rd_reg;
	 assign aluRes_out = aluRes_reg;
	 assign readData_out = readData_reg;

endmodule

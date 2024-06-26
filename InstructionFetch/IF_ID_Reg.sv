module IF_ID_Reg(
    input logic clk,              // Reloj del sistema
    input logic reset,            // Reset asíncrono
    
	 input logic [15:0] pc_in,     // Valor de PC de la etapa IF
    input logic [15:0] pc_plus2_in, // Valor de PC+4 de la etapa IF
    input logic [15:0] instruction_in, // Instrucción de la etapa IF
	 
    output logic [15:0] pc_out,         // Valor de PC almacenado
    output logic [15:0] pc_plus2_out,   // Valor de PC+4 almacenado
    output logic [15:0] instruction_out // Instrucción almacenada
);

    // Define registros internos para almacenar los valores entre etapas
    logic [15:0] pc_reg;
    logic [15:0] pc_plus2_reg;
    logic [15:0] instruction_reg;

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Limpia los registros si la señal de reset está activa
            pc_reg <= 16'b0;
            pc_plus2_reg <= 16'b0;
            instruction_reg <= 16'b0;
        end else begin
            // Actualiza los registros
            pc_reg <= pc_in;
            pc_plus2_reg <= pc_plus2_in;
            instruction_reg <= instruction_in;
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
    assign pc_out = pc_reg;
    assign pc_plus2_out = pc_plus2_reg;
    assign instruction_out = instruction_reg;

endmodule

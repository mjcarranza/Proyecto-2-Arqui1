`timescale 1ns / 1ps

module fetch_tb;

    // Entradas para el módulo fetch
    logic clk;
    logic rst;
    logic PCSrcE;
    logic [15:0] PCTargetE;
    logic [15:0] PCPlus2F;

    // Salidas del módulo fetch
    logic [15:0] InstrD;
    logic [15:0] PCPlus2D;

    // Instancia del módulo fetch
    fetch uut (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .PCPlus2F(PCPlus2F),
        .InstrD(InstrD),
        .PCPlus2D(PCPlus2D)
    );

    // Generador de reloj
    always #5 clk = ~clk; // Reloj con periodo de 10ns

    // Procedimiento de inicialización y prueba
    initial begin
			// Inicialización de señales
			clk = 1;
			rst = 0;  // Iniciar en reset
			PCSrcE = 0;
			PCTargetE = 16'h0000;
			PCPlus2F = 16'h0000;

			// Desactivar reset y aplicar señales de prueba
			//#5 rst = 0;

			#10 PCSrcE = 0; // Volver a seleccionar PCPlus2F
				PCPlus2F = 16'h0001;

			#10 PCSrcE = 0; // Cambiar nuevamente a PCTargetE
				PCPlus2F = 16'h0010;
				
			#10 PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            PCPlus2F = 16'h0011; 
				
			#10 PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            PCPlus2F = 16'h0100;

    end

endmodule

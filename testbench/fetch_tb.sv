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
        clk = 0;
        rst = 1;  // Iniciar en reset
        PCSrcE = 0;
        PCTargetE = 16'h0000;
        PCPlus2F = 16'h0002;

        // Desactivar reset y aplicar señales de prueba
        #10 rst = 0;
        #10 PCSrcE = 1; // Cambiar la fuente del PC para seleccionar PCTargetE
            PCTargetE = 16'h0010;

        #20 PCSrcE = 0; // Volver a seleccionar PCPlus2F
            PCPlus2F = 16'h0004;

        #10 PCSrcE = 1; // Cambiar nuevamente a PCTargetE
            PCTargetE = 16'h0020;

    end

endmodule

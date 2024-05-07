`timescale 1ps / 1ps

module execute_tb;

    // Parámetros del módulo
    parameter CLK_PERIOD = 10; // Periodo del reloj en ps

    // Señales de entrada
    logic clk;
    logic rst;
    logic regWriteE;
    logic memWriteE;
    logic jumpE;
    logic branchE;
    logic aluSrcE;
    logic [1:0] resultSrcE;
    logic [3:0] aluControlE;
    logic [15:0] RD1E;
    logic [15:0] RD2E;
    logic [15:0] PCPlus2E;
    logic [15:0] PCE;
    logic [15:0] extendedE;
    logic [3:0] RdE;

    // Señales de salida
    logic regWriteM;
    logic memWriteM;
    logic PCSrcE;
    logic [1:0] resultSrcM;
    logic [15:0] PCPlus2M;
    logic [15:0] aluResM;
    logic [15:0] writeDataM;
    logic [3:0] RdM;

    // Instancia del módulo execute
    execute execute_inst (
        .clk(clk),
        .rst(rst),
        .regWriteE(regWriteE),
        .memWriteE(memWriteE),
        .jumpE(jumpE),
        .branchE(branchE),
        .aluSrcE(aluSrcE),
        .resultSrcE(resultSrcE),
        .aluControlE(aluControlE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCPlus2E(PCPlus2E),
        .PCE(PCE),
        .extendedE(extendedE),
        .RdE(RdE),
        .regWriteM(regWriteM),
        .memWriteM(memWriteM),
        .PCSrcE(PCSrcE),
        .resultSrcM(resultSrcM),
        .PCPlus2M(PCPlus2M),
        .aluResM(aluResM),
        .writeDataM(writeDataM),
        .RdM(RdM)
    ); 

    // Generación de reloj
    always #CLK_PERIOD clk = ~clk;

    // Inicialización 
    initial begin
        clk = 0;
        rst = 1; // Inicialmente, establece el reset en alto
        regWriteE = 0;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        aluSrcE = 0;
        resultSrcE = 2'b00;
        aluControlE = 4'b0000;
        RD1E = 16'h0000;
        RD2E = 16'h0000;
        PCPlus2E = 16'h0000;
        PCE = 16'h0000;
        extendedE = 16'h0000;
        RdE = 4'b0000;

        // Espera un poco antes de liberar el reset
        #10;
        rst = 0;

        regWriteE = 0;
        memWriteE = 0;
        jumpE = 1;
        branchE = 1;
        aluSrcE = 1;
        resultSrcE = 2'b00;
        aluControlE = 4'b0101;
        RD1E = 16'h0000;
        RD2E = 16'h0000;
        PCPlus2E = 16'h0000;
        PCE = 16'h0000;
        extendedE = 16'h0000;
        RdE = 4'b0000;
		  
        #10;
        #10;
        rst = 0;

        regWriteE = 0;
        memWriteE = 0;
        jumpE = 0;
        branchE = 1;
        aluSrcE = 1;
        resultSrcE = 2'b00; 
        aluControlE = 4'b0101;
        RD1E = 16'h0000;
        RD2E = 16'h0000;
        PCPlus2E = 16'h0000;
        PCE = 16'h0000;
        extendedE = 16'h0000;
        RdE = 4'b0000;
    end

endmodule

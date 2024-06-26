`timescale 1ns / 1ps

module decode_tb;

    // Entradas para el módulo decode
    logic clk, rst, regWriteWB;
    logic [15:0] inst, PCPlus2, resultWB;
    logic [3:0] RdestW;

    // Salidas del módulo decode
    logic [15:0] PCPlus2E, RD1E, RD2E, PCE, immExtE;
    logic [3:0] RdE;
    logic regWriteE, memWriteE, jumpE, branchE, aluSrcE;
    logic [2:0] aluControlE;
    logic [1:0] resultSrcE;

    // Instancia del módulo decode
    decode uut (
        .clk(clk), .rst(rst), .regWriteWB(regWriteWB),
        .inst(inst), .PCPlus2(PCPlus2), .resultWB(resultWB), .RdestW(RdestW),
        .PCPlus2E(PCPlus2E), .RD1E(RD1E), .RD2E(RD2E), .PCE(PCE), .immExtE(immExtE),
        .RdE(RdE), .regWriteE(regWriteE), .memWriteE(memWriteE), .jumpE(jumpE), .branchE(branchE),
        .aluSrcE(aluSrcE), .aluControlE(aluControlE), .resultSrcE(resultSrcE)
    );

    // Generador de reloj
    always #5 clk = ~clk; // Reloj con periodo de 10ns

    // Procedimiento de inicialización y prueba
    initial begin
        // Inicialización de señales
        clk = 0;
        rst = 1;  // Iniciar en reset
        regWriteWB = 0;
        inst = 16'h6103;
        PCPlus2 = 16'h0002;
        resultWB = 16'h0000;
        RdestW = 4'h0;

        // Salir del reset y aplicar señales de prueba
        #10 rst = 0;
        #10 inst = 16'h1234; // Código de operación arbitrario
            regWriteWB = 1;
            resultWB = 16'h0010;
            RdestW = 4'h1;

        #20 inst = 16'h5678; // Otro código de operación
            PCPlus2 = 16'h0004;
    end


endmodule

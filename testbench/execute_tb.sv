`timescale 1ns / 1ps

module execute_tb;

    // Definición de constantes
    localparam CLK_PERIOD = 10; // Periodo del reloj en ns
    
    // Señales de entrada
    logic clk, rst, regWriteE, memWriteE, jumpE, branchE, aluSrcE;
    logic [1:0] resultSrcE;
    logic [3:0] aluControlE;
    logic [15:0] RD1E, RD2E, PCPlus2E, PCE, extendedE;
    logic [3:0] RdE;
    
    // Señales de salida
    logic regWriteM, memWriteM, PCSrcE;
    logic [1:0] resultSrcM; 
    logic [15:0] PCPlus2M, aluResM, writeDataM;
    logic [3:0] RdM;
    
    // Instancia del módulo execute
    execute execute_inst(
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
    
    // Generación de clock
    always #CLK_PERIOD clk = ~clk;
    
    // Inicialización de señales
    initial begin
        clk = 0;
        rst = 1; // Activa el reset inicialmente
        regWriteE = 0;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        aluSrcE = 0;
        resultSrcE = 0;
        aluControlE = 0;
        RD1E = 16'h0000;
        RD2E = 16'h0000;
        PCPlus2E = 16'h0000;
        PCE = 16'h0000;
        extendedE = 16'h0000;
        RdE = 4'b0000;
        
        // Espera un poco después de aplicar el reset
        #20;
        
        // Desactiva el reset
        rst = 0;
        
        // Simula una secuencia de operaciones
        
        // Operación 1
        RD1E = 16'h0010;
        RD2E = 16'h000F;
        PCPlus2E = 16'h0002;
        RdE = 4'b0010;
        aluControlE = 4'b0010; // Suma
        aluSrcE = 0; // RD2E
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 2
        RD1E = 16'h0012;
        RD2E = 16'h0005;
        PCPlus2E = 16'h0004;
        RdE = 4'b0011;
        aluControlE = 4'b0000; // AND
        aluSrcE = 1; // extendedE
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 3
        RD1E = 16'h0014;
        RD2E = 16'h000B;
        PCPlus2E = 16'h0006;
        RdE = 4'b0100;
        aluControlE = 4'b0011; // Resta
        aluSrcE = 0; // RD2E
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 4
        RD1E = 16'h0016;
        RD2E = 16'h0007;
        PCPlus2E = 16'h0008;
        RdE = 4'b0101;
        aluControlE = 4'b0110; // OR
        aluSrcE = 1; // extendedE
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 5
        RD1E = 16'h0018;
        RD2E = 16'h0003;
        PCPlus2E = 16'h000A;
        RdE = 4'b0110;
        aluControlE = 4'b1100; // Desplazamiento lógico a la izquierda
        aluSrcE = 0; // RD2E
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 6
        RD1E = 16'h0020;
        RD2E = 16'h000F;
        PCPlus2E = 16'h000C;
        RdE = 4'b0111;
        aluControlE = 4'b1000; // Desplazamiento lógico a la derecha
        aluSrcE = 1; // extendedE
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 7
        RD1E = 16'h0022;
        RD2E = 16'h000B;
        PCPlus2E = 16'h000E;
        RdE = 4'b1000;
        aluControlE = 4'b1010; // Comparación de igualdad
        aluSrcE = 0; // RD2E
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 8
        RD1E = 16'h0024;
        RD2E = 16'h0007;
        PCPlus2E = 16'h0010;
        RdE = 4'b1001;
        aluControlE = 4'b1011; // Comparación de desigualdad
        aluSrcE = 1; // extendedE
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 9
        RD1E = 16'h0026;
        RD2E = 16'h000A;
        PCPlus2E = 16'h0012;
        RdE = 4'b1010;
        aluControlE = 4'b1110; // Carga inmediata
        aluSrcE = 0; // RD2E
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
        
        // Operación 10
        RD1E = 16'h0028;
        RD2E = 16'h000D;
        PCPlus2E = 16'h0014;
        RdE = 4'b1011;
        aluControlE = 4'b1101; // Operación sin efecto
        aluSrcE = 1; // extendedE
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        // Espera un poco
        #20;
    end
    
endmodule

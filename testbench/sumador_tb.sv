`timescale 1ns / 1ps
module sumador_tb;

  // Señales de entrada/salida del módulo
  logic [15:0] A;
  logic [15:0] B;
  logic [15:0] C;

  // Instancia del módulo adder
  sumador adder_inst (
    .A(A),
    .B(B),
    .C(C)
  );

  // Inicialización de señales
  initial begin
    // Generar datos aleatorios para A y B
    A = 16'h0000;
    B = 16'h0001;

    // Imprimir valores iniciales
    #5;
    // Cambiar los valores de A y B
    A = 16'h1;
    B = 16'h1;
	 #5;
    // Cambiar los valores de A y B
    A = 16'h2;
    B = 16'h1;
	 #5;
    // Cambiar los valores de A y B
    A = 16'h3;
    B = 16'h1;


  end

endmodule

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
    A = $random;
    B = 16'h4;

    // Imprimir valores iniciales
    $display("Tiempo 0: A = %0d, B = %0d, C = %0d", A, B, C);
    #5;

    // Cambiar los valores de A y B
    A = $random;
    B = $random;
	 #5;

    // Imprimir valores después del cambio
    $display("Tiempo 5: A = %0d, B = %0d, C = %0d", A, B, C);

  end

endmodule

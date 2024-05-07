module register_file_tb;

  // Parámetros de reloj
  logic clk;
  logic rst;

  // Señales de control y datos
  logic regWrite;
  logic [3:0] A1, A2, A3;
  logic [15:0] WD3;

  // Señales de salida del módulo
  logic [15:0] RD1, RD2;

  // Instancia del módulo register_file
  register_file reg_file_inst (
    .clk(clk),
    .rst(rst),
    .regWrite(regWrite),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .WD3(WD3),
    .RD1(RD1),
    .RD2(RD2)
  );

  // Inicialización de señales
  initial begin
    // Inicializar reloj
    clk = 0;

    // Inicializar otras señales
    rst = 1;
    regWrite = 0;
    A1 = 4'b0000;
    A2 = 4'b0001;
    A3 = 4'b0000;
    WD3 = 16'h2222;

    // Ciclo de simulación
    repeat (40) begin
		
      // Ciclo de reloj
      #5 clk = ~clk;
		
		if ($time == 15) begin // escribir 
			A3 = 4'b0000;
			WD3 = 16'h2222;
			rst = 0;
			regWrite = 1;
			// escribo lo de wd3 en el registro 1

		end
		
		if ($time == 20) begin // escribir 
			A3 = 4'b0001;
			WD3 = 16'hFF00;
			rst = 0;
			regWrite = 1;
			// escribo lo de wd3 en el registro 0
			 // 
 
		end

      if ($time == 30) begin // leer
        rst = 0;
        regWrite = 0; 
		  
      end
    end


  end

endmodule

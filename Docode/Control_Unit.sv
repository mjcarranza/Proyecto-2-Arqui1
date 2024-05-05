module Control_Unit(
	input [3:0] operation, // 4 Bits para el codigo de operacion
	input imm, // bandera de inmediato
	output regWrite, memWrite, jump, branch, aluSrc, // banderas de 1 bit
	output [1:0] resultSrc, // bandera de 2 bits
	output [2:0] aluControl  // bandera de 3 bits
	);
	
	logic [1:0] resSrc;
	logic [2:0] Control;
	logic rWrite, mWrite, j, b, aSrc;
	
	
	
	always @(*)
	
		case (operation)
		
			 4'b0000: begin // acciones para ADD
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b00;  // guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 4'b0000;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 
			 4'b0001: begin // acciones para SUB
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b00;  // guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 4'b0001;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b0010: begin // acciones para AND
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b00;  // guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 4'b0010;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b0011: begin // acciones para ORR
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b00;  // guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 4'b0011;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b0100: begin // acciones para LSL
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b00;  // guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 4'b0100;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b0101: begin // acciones para CMP  // VERIFICAR BANDERAS DE CERO DE LA ALU
				  if (imm) begin // si tengo un inmediato // 1=si 0=no
						rWrite = 1;			// habilita bandera para escribir en registro // CHECK ------
						resSrc = 2'b00;  // guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						j = 0;				// no hay jump
						b = 0;			// no hay branch
						Control = 4'b0101;// numero de operacion para la alu // SUMAR CERO EN ALU
						aSrc = 1;			// fuente del segundo dato para la alu (inmediato)
				  end
				  else begin
						rWrite = 1;			// habilita bandera para escribir en registro // CHECK ------ 
						resSrc = 2'b00;  // guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						j = 0;				// no hay jump
						b = 0;			// no hay branch
						Control = 4'b0110;// numero de operacion para la alu // SUMAR CERO EN ALU
						aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
				  end
				  
			 end
			 4'b0110: begin // acciones para SET
				  if (imm) begin // si tengo un inmediato
						rWrite = 1;			// habilita bandera para escribir en registro
						resSrc = 2'b00;  // guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						j = 0;				// no hay jump
						b = 0;			// no hay branch
						Control = 4'b0110;// numero de operacion para la alu // SUMAR CERO EN ALU
						aSrc = 1;			// fuente del segundo dato para la alu (inmediato)
				  end
				  else begin
						rWrite = 1;			// habilita bandera para escribir en registro
						resSrc = 2'b00;  // guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						j = 0;				// no hay jump
						b = 0;			// no hay branch
						Control = 3'b100;// numero de operacion para la alu // SUMAR CERO EN ALU
						aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
				  end
			 end
			 4'b0111: begin // acciones para LDR
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b01;  // guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 4'b0111;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b1000: begin // acciones para STR
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 2'b01;  // guarda en registro el result de la memoria
					mWrite = 1;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 3'b100;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b1001: begin // acciones para B
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b01;  // guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					j = 1;				// no hay jump
					b = 1;			// no hay branch
					Control = 3'b100;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b1010: begin // acciones para BEQ
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b01;  // guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					j = 1;				// no hay jump
					b = 1;			// no hay branch
					Control = 3'b100;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 4'b1011: begin // acciones para BGE
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 2'b01;  // guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					j = 1;				// no hay jump
					b = 1;			// no hay branch
					Control = 3'b100;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
			 
			 default: begin // acciones para NOT (stall)
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 2'b00;  // guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					j = 0;				// no hay jump
					b = 0;			// no hay branch
					Control = 3'b000;// numero de operacion para la alu
					aSrc = 0;			// fuente del segundo dato para la alu (contenido de registro)
			 end
		endcase
		

		
	assign regWrite = rWrite;
	assign memWrite = mWrite;
	assign jump = j;
	assign branch = b;
	assign aluSrc = aSrc;
	assign resultSrc = resSrc;
	assign aluControl = Control;
	
endmodule 
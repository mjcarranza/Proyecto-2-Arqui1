module Control_Unit(

    input [15:0] op, // 4 Bits para el codigo de operacion
	 input imm, // bandera de inmediato
    output regWrite, memWrite, jump, branch, aluSrc, // banderas de 1 bit
	 output [1:0] resultSrc, // bandera de 2 bits
    output [2:0] aluControl  // bandera de 3 bits
	 );
	 
	 logic [3:0] op;

	always_comb
	case (op)
		 4'b0000: begin // acciones para ADD
			  assign regWrite = 1;
			  assign ResultSrc = 2'b00;
			  assign memWrite = 0;
			  assign jump = 0;
			  assign branch = 0;
			  assign aluControl = 3'b000; 
			  assign aluSrc = 0;					  
		 end
		 
		 4'b0001: begin // acciones para SUB
			  assign regWrite = 1;
			  assign ResultSrc = 2'b00;
			  assign memWrite = 0;
			  assign jump = 0;
			  assign branch = 0;
			  assign aluControl = 3'b001; 
			  assign aluSrc = 0;	
		 end
		 4'b0010: begin // acciones para AND
			  assign regWrite = 1;
			  assign ResultSrc = 2'b00;
			  assign memWrite = 0;
			  assign jump = 0;
			  assign branch = 0;
			  assign aluControl = 3'b010; 
			  assign aluSrc = 0;	
		 end
		 4'b0011: begin // acciones para ORR
			  assign regWrite = 1;
			  assign ResultSrc = 2'b00;
			  assign memWrite = 0;
			  assign jump = 0;
			  assign branch = 0;
			  assign aluControl = 3'b011; 
			  assign aluSrc = 0;	
		 end
		 4'b0100: begin // acciones para LSL
			  assign regWrite = 1;
			  assign ResultSrc = 2'b00;
			  assign memWrite = 0;
			  assign jump = 0;
			  assign branch = 0;
			  assign aluControl = 3'b100; 
			  assign aluSrc = 0;	
		 end
		 4'b0101: begin // acciones para CMP
			  if (imm) begin // si tengo un inmediato
					assign regWrite = 1;
				   assign ResultSrc = 2'b00;
				   assign memWrite = 0;
				   assign jump = 0;
				   assign branch = 0;
				   assign aluControl = 3'b100; 
				   assign aluSrc = 1;	
			  end
			  else begin
					assign regWrite = 1;
					assign ResultSrc = 2'b00;
					assign memWrite = 0;
					assign jump = 0;
					assign branch = 0;
					assign aluControl = 3'b100; 
					assign aluSrc = 0;	
			  end
			  
		 end
		 4'b0110: begin // acciones para SET
			  if (imm) begin // si tengo un inmediato
					assign regWrite = 1;
				   assign ResultSrc = 2'b00;
				   assign memWrite = 0;
				   assign jump = 0;
				   assign branch = 0;
				   assign aluControl = 3'b100; 
				   assign aluSrc = 1;	
			  end
			  else begin
					assign regWrite = 1;
					assign ResultSrc = 2'b00;
					assign memWrite = 0;
					assign jump = 0;
					assign branch = 0;
					assign aluControl = 3'b100; 
					assign aluSrc = 0;	
			  end
		 end
		 4'b0111: begin // acciones para LDR
			  // Acciones para el valor1
		 end
		 4'b1000: begin // acciones para STR
			  // Acciones para el valor1
		 end
		 4'b1001: begin // acciones para B
			  // Acciones para el valor1
		 end
		 4'b1010: begin // acciones para BEQ
			  // Acciones para el valor1
		 end
		 4'b1011: begin // acciones para BGE
			  // Acciones para el valor1
		 end
		 
		 default: begin // acciones para NOT (stall)
			  // Acciones por defecto si ningún caso anterior coincide
		 end
	endcase



endmodule




// OpCode rd rm rn
// 4       4  4  4

// 0000: ADD 
// 0001: SUB 
// 0010: AND 
// 0011: ORR 
// 0100: LSL 



// OP RD RM/IMM IMM?
// 4  4   7      1

// 0101: CMP 
// 0110: SET


//OP RD RM --
// 4  4  4  4

// 0111: LDR 
// 1000: STR 


// OP ETIQUETA
// 4  12

// 1001: B 
// 1010: BEQ 
// 1011: BGE 


// OP --
// 4  12

// 1100: NOT 
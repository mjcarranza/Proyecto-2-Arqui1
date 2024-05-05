module alu(
	input [31:0] A, B,
	input [3:0] sel,
	output [31:0] alu_out,
	output zero, negative, carry
	);
	
	reg [31:0] alu_out_temp;
	wire [8:0] tmp;
	
	
	
	always @(*)
	
		case (sel)
		
			// caso de la suma
			4'b0000: alu_out_temp = A + B; 
			
			// caso de la resta
			4'b0001: alu_out_temp = A - B;
			
			// caso de AND
			4'b0010: alu_out_temp = A && B;

			//caso de OR
			4'b0011: alu_out_temp = A || B;

			//caso de LSL
			4'b0011: alu_out_temp = A << B;

			//caso de CMP
			4'b0101: alu_out_temp = A - B;

			if(alu_out_temp == 0) begin
				assign zero = 1'b1;
			end 

			//caso de SET
			4'b0110: alu_out_temp = A;

			//caso de LDR
			4'b0111: alu_out_temp = A;

			// caso de STR
			4'b1000: alu_out_temp = A;

			// caso de Branch
			4'b1001: alu_out_temp = A;

			// caso de BEQ
			4'b1010: alu_out_temp = A;

			// caso de BGE
			4'b1011: alu_out_temp = A;
			
			//STALL
			default: alu_out_temp = 0 
		
		endcase 
		

		
	// resultado de la alu
	assign alu_out = alu_out_temp;
	
	// banderas
	assign zero = (alu_out_temp == 31'd0);	// bandera de cero (Z)
	
	assign carry = 1'b0;
	
endmodule 
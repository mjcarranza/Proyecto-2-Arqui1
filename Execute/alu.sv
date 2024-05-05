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
			4'b0000: begin 
				alu_out_temp = A + B; 
			end
			
			// caso de la resta
			4'b0001: begin 
				alu_out_temp = A - B;
			end
			
			// caso de AND
			4'b0010: begin
				alu_out_temp = A && B;
			end

			//caso de OR
			4'b0011: begin
				alu_out_temp = A || B;
			end
				
			//caso de LSL
			4'b0011: begin 
				alu_out_temp = A << B;
			end

			//caso de CMP
			4'b0101: begin 
				alu_out_temp = A - B;
				//if(alu_out_temp == 0) begin
				//	assign zero = 1'b1;
				//end 
			end

			//caso de SET
			4'b0110: begin 
				alu_out_temp = A;
			end

			//caso de LDR
			4'b0111: begin 
				alu_out_temp = A;
			end

			// caso de STR
			4'b1000: begin 
				alu_out_temp = A;
			end

			// caso de Branch
			4'b1001: begin
				alu_out_temp = A;
			end

			// caso de BEQ
			4'b1010: begin	
				alu_out_temp = A;
			end

			// caso de BGE
			4'b1011: begin 
				alu_out_temp = A;
			end
			
			//STALL
			default: begin 
				alu_out_temp = 0;
			end
		
		endcase 
		

		
	// resultado de la alu
	assign alu_out = alu_out_temp;
	
	// banderas
	assign zero = (alu_out_temp == 31'd0);	// bandera de cero (Z)
	
	assign carry = 1'b0;
	
endmodule 
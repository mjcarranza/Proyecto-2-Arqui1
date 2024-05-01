module mux_WB( input logic [15:0] data0,
					input logic [15:0] data1,
					input logic [15:0] data2,
					input logic [1:0] select,
					output logic [15:0] result);

  always_comb begin
	  case (select)
			
				 2'b00: begin // acciones para ADD
						result = data0;			// fuente del segundo dato para la alu (contenido de registro)
				 end
				 2'b01: begin // acciones para ADD
						result = data1;			// fuente del segundo dato para la alu (contenido de registro)
				 end
				 2'b10: begin // acciones para ADD
						result = data2;			// fuente del segundo dato para la alu (contenido de registro)
				 end
				 default: begin // acciones para NOT (stall)
						result = data0;			// fuente del segundo dato para la alu (contenido de registro)
				 end
		endcase
  end

endmodule
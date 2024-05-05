
module program_counter(input logic clk, rst, stop,
							  input logic [15:0] d,
							  output logic [15:0] q);

always_ff @(posedge clk)
	if (stop == 1) begin
		q <= 0;
	end
	else if (rst == 1) begin
		q <= 0;
	end
	else begin 
		q <= d;
	end

endmodule
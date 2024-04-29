
module program_counter(input logic clk, rst,
							  input logic [15:0] d,
							  output logic [15:0] q);

always_ff @(posedge clk)
	if (rst == 1) q <= 0;
	else q <= d;

endmodule
module videoGen(
	input logic clk, rst,
	input logic [9:0] x, y,
	input logic [7:0] pixel,  // 8 bits por pixel
	output logic [7:0] r, g, b,
	output logic [15:0] address // direccion donde voy a ir a buscar el valor del pixela pintar
);

	
	always_ff @(posedge clk or posedge rst) begin
		
		// calcular el address para obtener el pixel
		
		if (rst) begin
			{r, g, b} = {8'hFF, 8'hFF, 8'hFF};
		end 
		else begin
			if (pixel == 8'h01) begin
				{r, g, b} = {8'hFF, 8'hFF, 8'hFF};
			end
			else begin
				{r, g, b} = {8'h00, 8'h00, 8'h00}; 
			end
		end
	end
	
endmodule 
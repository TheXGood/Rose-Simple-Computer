module register(clk, in, val, write,clear);
	
	input wire clk;
	input wire write;
	input wire [15:0]in;
	input wire clear;
	
	output wire [15:0]val;
	
	reg [15:0]rval;
	
	assign val = rval;
	
	
	always @(posedge clk) begin
	
		if(clear == 1'b1) begin
			rval = 0;
		end
		
		else if(write == 1'b1) begin
			rval = in;
		end
		
		
	end
	
	
	

endmodule
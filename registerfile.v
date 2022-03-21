module registerFile(clk, inaddr, in, addr1, addr2, out1, out2, write, clear);
	
	input wire clk;
	input wire write;
	input wire [15:0]in;
	input wire clear;
	input wire [2:0]addr1;
	input wire [2:0]addr2;
	input wire [2:0]inaddr;
	
	output reg [15:0]out1;
	output reg [15:0]out2;
	
	
	reg [15:0]vals[7:0];
	
	always @(posedge clk) begin
	
		if(clear == 1'b1) begin
			vals[3'd0] <= 16'b0;
			vals[3'd1] <= 16'b0;
			vals[3'd2] <= 16'b0;
			vals[3'd3] <= 16'b0;
			vals[3'd4] <= 16'b0;
			vals[3'd5] <= 16'b0;
			vals[3'd6] <= 16'b0;
			vals[3'd7] <= 16'b0;
		end
		
		if(write == 1'b1) vals[inaddr] = in;
		
		//These are noblocking, since they should be concurrent
		out1 <= vals[addr1];
		out2 <= vals[addr2];
		
		
	end
	
	
	

endmodule
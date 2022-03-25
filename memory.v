//There is one address for instruction fetch
//And a second for general purpose



module memory(clk,addr1,addr2,word1,word2);
	
	input wire clk;
	input wire [15:0]addr1;
	input wire [15:0]addr2;
	
	reg [15:0]block_memory[15:0];
	
	output reg [15:0]word1;
	output reg [15:0]word2;
	
	initial begin
		
		$readmemh("bram.hex",block_memory,0,0);
	
	end
	
	always @(posedge clk) begin
		
		word1 <= block_memory[addr1];
		word2 <= block_memory[addr2];
	end


endmodule
//There is one address for instruction fetch
//And a second for general purpose



module memory(clk,addr1,addr2,word1,word2);
	
	input wire clk;
	input wire [15:0]addr1;
	input wire [15:0]addr2;
	
	reg [15:0]block_memory[15:0];
	
	output reg [15:0]word1;
	output reg [15:0]word2;
	
	integer i;
	
	initial begin
		
		for (i=0;i<65536;i=i+1) begin
			block_memory[i] = 0;
		end
		
		$readmemb("bram.hex",block_memory,0,3);
		
		$display("block_memory[0] == %d",block_memory[0]);
		$display("block_memory[1] == %d",block_memory[1]);
		$display("block_memory[2] == %d",block_memory[2]);
		$display("block_memory[3] == %d",block_memory[3]);
		$display("block_memory[15] == %d",block_memory[15]);
	
	end
	
	always @( clk) begin
		
		word1 = block_memory[addr1];
		word2 = block_memory[addr2];
	end


endmodule
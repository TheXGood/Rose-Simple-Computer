
`define CMD 64
`define CRC 8'h95

//DO must be high while sending
//DI must be high while recieving



module SD_Reader(clk,DO,DI);
	
	input wire clk;
	reg count;
	reg [7:0]current_command;//64 + Command ID
	
	output reg DO;
	
	//1-6 since there are 6 bytes in one SPI packet
	//0 for not currently sending.
	
	
	reg [2:0]byte_state;
	
	
	always @(posedge clk)begin
		
		if(byte_state != 0)
			DO = 1;
		
		
		
	end
	
	
endmodule


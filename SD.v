//
//
//
//


module SD(clk,write,addr,out);
	
	input wire clk;
	input wire write;
	input wire addr;
	
	output reg [7:0]out[3:0];	//4 bytes
	
	SD_Reader internal();//Ipcore goes here
	
	always @(posedge clk) begin
		
		if(write == 1'b1) begin
		//Write	
		else
		//Read
		
		end
	end
	

endmodule
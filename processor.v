`include "alu.v"
`include "register.v"
`include "registerfile.v"


//No instruction located at IP below K*4 may modify code below K*4
//If it does, an interrupt should occur immediately.


module processor(clk);

	input wire clk;
	
	wire [15:0]ip_val;
	
	ALU alu();
	register IP(clk,(ip_val + 16'b1),ip_val,1'b1,);
	
	registerFile registers(clk,,,,,,,,);
	

endmodule


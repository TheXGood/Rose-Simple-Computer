`include "alu.v"
`include "register.v"
`include "registerfile.v"
`include "memory.v"

//No instruction located at IP below K*4 may modify code below K*4
//If it does, an interrupt should occur immediately.

`define OPCODE instruction_value[15:11]
`define IMM instruction_value[4:0]


module processor(clk);

	input wire clk;
	
	wire [15:0]ip_val;
	wire [15:0]instruction_value;
	
	memory mem(clk,(ip_val << 1'b1),,instruction_value,);
	ALU alu();
	register IP(clk,,ip_val,1'b1,);
	register EIP(clk,,,,);
	registerFile registers(clk,,,,,,,,);
	

endmodule


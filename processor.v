`include "alu.v"
`include "register.v"
`include "registerfile.v"
`include "memory.v"
`include "controlunit.v"
`include "IO.v"

//No instruction located at IP below K*4 may modify code below K*4
//If it does, an interrupt should occur immediately.

`define OPCODE instruction_buffer[15:11]
`define IMM instruction_buffer[4:0]


module processor(clk);

	input wire clk;
	
	wire [15:0]ip_val;
	wire [15:0]eip_val;
	wire [15:0]instruction_value;
	wire [15:0]k_val;
	
	
	wire ip_write;
	wire eip_write;
	
	
	wire IOorMem;
	wire ALUorMem;
	wire Except;
	wire Sign;
	wire Zero;
	wire writeback;
	
	wire [3:0]alu_op;
	
	wire [15:0]a_val;
	wire [15:0]b_val;
	
	wire [15:0]a_in;
	wire [15:0]b_in;
	wire [15:0]ivr_val;
	wire [15:0]ivl_val;
	
	
	wire [15:0]alu_out;
	
	wire [15:0]address_line;
	wire [15:0]ioout;
	wire [15:0]memout;
	wire [15:0]databus;
	wire [15:0]regbus;
	wire [15:0]instruction_buffer;
	
	assign databus = (ioout & {16{IOorMem}}) | (memout & ~{16{IOorMem}});//Multiplex io vs memory outs
	assign regbus = (alu_out & {16{ALUorMem}}) | (databus & ~{16{ALUorMem}});
	assign regaddr = (3'b001 & {3{BorA}});
	
	wire preserve_tmp;
	
	memory mem(clk,(ip_val),address_line,instruction_value,memout);
	
	ALU alu(alu_op,a_val,b_val,`IMM,alu_out,Zero,clk,Sign);
	
	
	register IP(clk,(ip_val + 16'b1),ip_val,ip_write,);
	register EIP(clk,ip_val,eip_val,eip_write,);
	register IVL(clk,{{11'b0},{`IMM}},ivl_val,,);
	register IVR(clk,a_in,ivr_val,,);
	register A(clk,a_in,a_val,~preserve_tmp,);
	register B(clk,b_in,b_val,~preserve_tmp,);
	register InstructionBuffer(clk,instruction_value,instruction_buffer,ip_write,);
	
	IO io(clk,address_line,ioout);
	
	
	registerFile registers(clk,regaddr | (instruction_buffer[7:5] & ~{3{BorA}}),regbus,instruction_buffer[7:5],instruction_buffer[10:8],a_in,b_in,writeback,1'b0);
	
	controlunit control(clk,instruction_buffer[15:11],ip_write,k_val,,,,,,,,alu_op,BorA,writeback,ALUorMem);
	

endmodule


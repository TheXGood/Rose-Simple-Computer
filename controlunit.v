//State Machine, and the "brain" of the processor
//
//
//

`define INST_NOP			5'b00000
`define INST_SWAP			5'b00001
`define INST_JMP			5'b00010
`define INST_PUSH			5'b00011
`define INST_POP			5'b00100
`define INST_ADD			5'b00101
`define INST_SUB			5'b00110
`define INST_MUL			5'b00111
`define INST_SHL			5'b01000
`define INST_SHR			5'b01001
`define INST_OR				5'b01010
`define INST_XOR			5'b01011
`define INST_AND			5'b01100
`define INST_MOD			5'b01101
`define INST_RAND			5'b01110
`define INST_READW			5'b01111
`define INST_WRITEW			5'b10000
`define INST_CALL			5'b10001
`define INST_RET			5'b10010
`define INST_BGE			5'b10011
`define INST_INT			5'b10100
`define INST_IRET			5'b10101
`define INST_LOADW			5'b10110
`define INST_STOW			5'b10111
`define INST_LIVT			5'b11000
`define INST_DELAY_SLOT 	5'b11001
`define INST_SETK			5'b11010
`define INST_GETK			5'b11011
`define INST_HLT			5'b11100
`define INST_DIV			5'b11101


module controlunit(clk,instruction,inc_ip,K_reg,sign,zero,IOorMem,preserve_tmp,reg_to_write,reg_write,set_ivl,alu_op,BorA,writeback,ALUorMem);

	input wire clk;
	input wire [4:0]instruction;
	
	input wire sign;
	input wire zero;
	input wire [15:0]K_reg;
	
	
	
	reg [5:0]instruction_state;
	reg [3:0]instruction_step;
	
	reg [5:0]next_instruction_state;
	reg [3:0]next_instruction_step;
	
	output reg IOorMem;
	output reg inc_ip;
	output reg preserve_tmp;
	output reg reg_write;
	output reg set_ivl;
	output reg BorA;
	output reg writeback;
	output reg ALUorMem;
	
	output reg [3:0]alu_op;
	
	output reg [3:0]reg_to_write;
	
	always @(posedge clk) begin
		
		
		instruction_state = next_instruction_state;
		instruction_step = next_instruction_step;
		
		if(inc_ip == 1'b1) begin
			
		end
		
		case(instruction_state)//This takes 2 cycles
			`INST_DELAY_SLOT: begin
				
				alu_op = 4'b0;
				
				if(instruction_step == 4'b10) begin
					inc_ip = 1;
					next_instruction_state = instruction;
					next_instruction_step = 4'b0;
					
				end else begin
					inc_ip = 0;
					next_instruction_state = `INST_DELAY_SLOT;
					next_instruction_step = instruction_step + 4'b1;
					
				end
			end
			`INST_NOP: begin //Should be 1 cycle
				alu_op = 4'b0;
				inc_ip = 1;
				next_instruction_state = instruction;
				next_instruction_step = 4'b0;
			end	
			`INST_ADD: begin
				if(instruction_step == 1'b0) begin
					inc_ip = 0;
					alu_op = 4'b0;//Do the work here, adding and stuff
					next_instruction_state = `INST_ADD;
					next_instruction_step = 4'b1;
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
				end else begin
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
					inc_ip = 1;
					next_instruction_state = instruction;
					next_instruction_step = 4'b0;
				end
				
			end		
			`INST_SUB: begin
				if(instruction_step == 1'b0) begin
					inc_ip = 0;
					alu_op = 4'b0001;//Do the work here, adding and stuff
					next_instruction_state = `INST_SUB;
					next_instruction_step = 4'b1;
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
				end else begin
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
					inc_ip = 1;
					next_instruction_state = instruction;
					next_instruction_step = 4'b0;
				end
				
			end			
			`INST_XOR: begin
				if(instruction_step == 1'b0) begin
					inc_ip = 0;
					alu_op = 4'b0110;//Do the work here, adding and stuff
					next_instruction_state = `INST_XOR;
					next_instruction_step = 4'b1;
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
				end else begin
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
					inc_ip = 1;
					next_instruction_state = instruction;
					next_instruction_step = 4'b0;
				end
				
			end
			`INST_MUL: begin
				if(instruction_step == 1'b0) begin
					inc_ip = 0;
					alu_op = 4'b0100;//Do the work here, adding and stuff
					next_instruction_state = `INST_MUL;
					next_instruction_step = 4'b1;
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
				end else begin
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
					inc_ip = 1;
					next_instruction_state = instruction;
					next_instruction_step = 4'b0;
				end
				
			end
			`INST_DIV: begin
				if(instruction_step == 1'b0) begin
					inc_ip = 0;
					alu_op = 4'b0111;//Do the work here, adding and stuff
					next_instruction_state = `INST_DIV;
					next_instruction_step = 4'b1;
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
				end else begin
					BorA = 1;//Store value into A
					writeback = 1;
					ALUorMem = 1;
					inc_ip = 1;
					next_instruction_state = instruction;
					next_instruction_step = 4'b0;
				end
				
			end
			`INST_LOADW: begin
				IOorMem = 0;//Set to memory
				ALUorMem = 0;//Set to memory
				BorA = 1;
				alu_op = 0;
				writeback = 1;
				inc_ip = 0;
				next_instruction_state = instruction;
				next_instruction_step = 4'b0;
			end
			
			//`INST_LOADW: begin
			//	if(instruction_step == 1'b0) begin
			//		
			//	end
			


			
			`INST_HLT: begin //infinite cycle instruction
				next_instruction_state = `INST_HLT;
				next_instruction_step = 4'b0;
				inc_ip = 0;
				alu_op = 4'b0;
			end
			
			
			
			default: begin
				next_instruction_state = instruction_state;
				next_instruction_step = 4'b0;
				inc_ip = 0;
				alu_op = 4'b0;
			end
		endcase
		
		
	end
	
	initial begin
	
		instruction_state = `INST_DELAY_SLOT;
		instruction_step = 4'b0;
		next_instruction_state = `INST_DELAY_SLOT;
		next_instruction_step = 4'b0;
	end
	

endmodule
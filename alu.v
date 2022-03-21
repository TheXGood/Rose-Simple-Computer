`timescale 1ns / 1ps

module ALU(op,A,B,Imm,Output,zero,clk);
	
	input [2:0]op;
	input [15:0]A;
	input [15:0]B;
	
	input clk;
	
	output [15:0]Output;
	output zero;
	
	reg [15:0]Output;
	reg zero;
	
	reg [15:0] RNG_out; //Stores the last number RNG outputted
	
	
	always @(posedge clk) begin
		
		
		case(op)
			
			3'b000:
				Output = A + B;
			3'b001:
				Output = A - B;
			3'b010:
				Output = A & B;
			3'b011:
				Output = A | B;
			3'b100:
				Output = A * B;
			3'b101:
				Output = A % B;
			3'b110:
				Output = A ^ B;
			3'b111:
				begin
				//Random value, more info in ALU_rand_tester.java
				
				//LCG RNG
				//RNG_out = ((75*RNG_out) + (73 + B)) % (65536);


				//XORSHIFT RNG credit to George Marsaglia
				
				RNG_out = RNG_out + 1;
				
				RNG_out = RNG_out ^ (RNG_out << 7);
				RNG_out = RNG_out ^ (RNG_out >> 9);
				RNG_out = RNG_out ^ (RNG_out << 8);
				
				
				//END XORSHIFT
				
				if(A == 16'b0)
					Output <= RNG_out;
				else Output <= RNG_out % A;
				
				end
				
		endcase
		
		if(Output == 16'b0) begin
			zero = 1;
		end else begin
			zero = 0;
		end
		
	end
endmodule



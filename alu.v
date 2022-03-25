`timescale 1ns / 1ps

module ALU(op,A,B,Imm,Output,zero,clk,sign);
	
	input [3:0]op;
	input [15:0]A;
	input [15:0]B;
	input [4:0]Imm;
	
	
	input clk;
	
	output [15:0]Output;
	output zero;
	output sign;
	
	
	reg [15:0]Output;
	reg zero;
	
	reg [15:0] RNG_out; //Stores the last number RNG outputted
	reg sign;
	
	
	
	always @(posedge clk) begin
		
		
		case(op)
			
			4'b0000:
				Output = A + B + {{11{Imm[4]}},Imm};//Sign Extend
			4'b0001:
				Output = A - B - {{11{Imm[4]}},Imm};
			4'b0010:
				Output = A & (B | Imm);
			4'b0011:
				Output = A | B | Imm;
			4'b0100:
				Output = A * (B+{{11{Imm[4]}},Imm});
			4'b0101:
				Output = A % B;
			4'b0110:
				Output = A ^ B;
			4'b0111:
				Output = A \ B;
			4'b1000:
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
			4'b1000: ;
			
			
		endcase
		
		if(Output == 16'b0) begin
			zero = 1;
		end else begin
			zero = 0;
		end
		
		if(Output[16] == 1'b0) begin
			sign = 0;
		end else begin
			sign = 1;
		end
		
	end
endmodule



`include "alu.v"
`timescale 1ns / 1ps


module ALU_tb;

	// inputs
	reg[15:0] A;
	reg[15:0] B;
	reg[3:0] Op;
	reg clk;

	// output
	wire[15:0] Output;

	ALU uut(
		.op(Op),
		.A(A),
		.B(B),
		.Imm(16),
		.Output(Output),
		.clk(clk)
	);
	parameter HALF_PERIOD = 50;
	
	initial begin
		clk = 0;
		forever begin
			#(HALF_PERIOD);
			clk = ~clk;
		end
	end
	
	initial begin

		$dumpfile("dump.vcd");
		$dumpvars();

		//inputs
		A = 16'b0000000000000000;
		Op = 4'b000;
		B = 16'b0000000000000000;
		
		#5
		$display("Adding gives %d",Output);
		
		#200
		
		A = 12;
		Op = 3'b111;
		
		
		//Wait a while to generate multiple numbers to view in the waveform
		#500
		
		//$display("RNG unclamped = %d",Output);
		//A = Output;
		//Op = 3'b101;
		//B = 255;
		#100
		
		$display("RNG clamped = %d",Output);
		
		
		$display("Tests completed.");
		
		
		
		$finish;
	end

endmodule
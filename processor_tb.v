`include "processor.v"

module toplevel();
	
	reg clk = 0;
	
	processor proc(clk);
	
	initial begin
		forever begin
			#50
			clk = ~clk;
		end
	end
	
	initial begin
	
		$dumpfile("dump.vcd");
		$dumpvars();

	
		#200
		
		$finish();
	end
	
	
	
	
endmodule;
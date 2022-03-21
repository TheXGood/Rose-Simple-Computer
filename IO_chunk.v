`timescale 1ns / 1ps

//Let's imagine this has io ports each size 8, so 8 wires
//There are two io ports on the chips, so 16 pins of the board 
//But, we'll take 4 extra pins, to make 2 2-bit multiplexers to select
//between each value

//That means each port 8 things it's multiplexed for, and there are 2 ports
//So that means theres 16 io bytes addresseable, so it's a 4 bit address

//IO ports are 0-15 are then 

//First half of address use port 1, second half are port 2



module ALU(ioaddr,data,clk);
	
	input clk;
	input ioaddr;
	
	reg ioaddr[];
	wire clk;
	
	inout data;
	
	
	
	always @(posedge clk) begin
		
	end
	
	
endmodule
`timescale 1ns / 1ps

//Let's imagine this has io ports each size 8, so 8 wires
//There are two io ports on the chips, so 16 pins of the board 
//But, we'll take 4 extra pins, to make 2 2-bit multiplexers to select
//between each value

//That means each port 8 things it's multiplexed for, and there are 2 ports
//So that means theres 16 io bytes addresseable, so it's a 4 bit address

//IO ports are 0-15 are then 

//First half of address use port 1, second half are port 2


//One concern about this IO system, is I'm not sure how it will need to be catered to the FPGA design, will be left as a shell.


module IO(clk,ioaddr,data);
	
	input clk;
	input [15:0]ioaddr;
	wire clk;
	inout [15:0]data;
	
endmodule
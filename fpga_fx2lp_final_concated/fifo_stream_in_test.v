`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:54 04/21/2018 
// Design Name: 
// Module Name:    fifo_stream_in_test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fifo_stream_in_test();

	reg clk;
	reg data_in;
	reg flagd;  //  EP6 full flag
	reg flaga;  //  EP2 empty flag
  
	wire [7:0] fdata;

	wire clk_o;  
	wire [1:0] faddr;  
	wire sloe;
	wire slrd;
	wire slwr;
	wire pkt_end;
  
	fifo_stream_in fifo_unit 
		(.clk(clk), .data_in(data_in), .flagd(flagd), .flaga(flaga), .fdata(fdata), .clk_o(clk_o),  
		 .faddr(faddr), .sloe(sloe), .slrd(slrd), .slwr(slwr), .pkt_end(pkt_end)); 
	
	//simulate clock
	initial 
	begin
		clk = 0;
		forever #50 clk = !clk;
	end
	
	//simulate others
	initial
	begin
		// ==== endpoint 6 is full ====
		flagd = 1'b0;
		
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		//repeat(2) @(negedge clk);
		
		// ==== endpoint 6 not full ====
		flagd = 1'b1;
		
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		
		flagd = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		
		flagd = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b1;
		
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		@(negedge clk);
		data_in = 1'b1;
		@(negedge clk);
		data_in = 1'b0;
		
		@(posedge clk);
		$stop;
	end
endmodule

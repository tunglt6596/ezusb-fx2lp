`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:52:53 04/17/2018 
// Design Name: 
// Module Name:    fifo_stream_in 
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
module fifo_stream_in(
  input clk,
  input data_in,
  input flagd,  //  EP6 full flag
  input flaga,  //  EP2 empty flag
  
  output [7:0] fdata,

  output clk_o,  
  output wire [1:0] faddr,  
  output wire sloe,
  output wire slrd,
  output reg slwr,
  output reg pkt_end
);

wire full = flagd;
wire empty = flaga;
reg [7:0] data_out;

/*
FIFOADR[1:0] Selected FIFO
	00 EP2
	01 EP4
	10 EP6
	11 EP8
*/
assign clk_o = clk;
assign faddr = 2'b10;
assign sloe = 1'b1;
assign slrd = 1'b1;
assign fdata = data_out;

parameter IDLE     	 = 2'b0;
parameter WRITE       = 2'b1;

reg current_state;
reg next_state;

initial begin
	next_state = IDLE;
	slwr <= 1'b1;
	pkt_end <= 1'b1;
end

//Stream IN mode state machine 
always @(posedge clk)
begin
    current_state <= next_state;
end

//write data to output
always @(posedge clk)
begin
	if (next_state == WRITE) begin
			data_out <= {7'b0, data_in};
	end
end

// state machine combo
always @ (*)
begin
  case(current_state)
	 IDLE: begin
		if(full == 1'b1)   //EP6 is not full
			next_state = WRITE;
		else 
			next_state = IDLE;
	 end
    WRITE: begin
		if (full == 1'b0) // EP6 is full
			next_state = IDLE;
		else 
			next_state = WRITE;
    end
    default: 
      next_state = IDLE;
  endcase
end

// write control signal generation
// register SLWR so it doesn't glitch
always @(posedge clk)
begin
	case (next_state)
		WRITE:
			slwr <= 1'b0; // Write Strobe
		default:
			slwr <= 1'b1; 
	endcase
end

endmodule


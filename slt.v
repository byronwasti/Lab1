// Set Less Than circuit

`timescale 1 ns/1 ps
// define gates with delays
`define AND and #30
`define OR or #30
`define XOR xor #50

`include "adder.v"

module SLTcircuit
(
    output boolean,
    input[31:0] a,
    input[31:0] b
);
    wire[31:0] a, b, newb;
    wire[31:0] carryin, sum, carryout;

    generate
        genvar i;
	for (i = 0; i<32; i = i + 1)
	    begin : gen1
		not notgate(newb[i], b[i]);
		fullAdder addmod(sum[i], carryout[i], a[i], newb[i], carryin[i]);
	    end
    endgenerate	
    and andgate(boolean, 1, carryout[31]);
endmodule

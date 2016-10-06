`timescale 1 ns / 1 ps
`include "alu.v"

module testBitSlice();

    reg a, b, carryin;
    reg [2:0] sel;
    reg negate;

    wire out, carryout;

    bitSliceALU bitslice0 (out, carryout, a, b, carryin, sel, negate);

    initial begin
        $display("a | b | ci | sel | neg || out co");
        a=1;b=1;sel=0;carryin=0;negate=0; #1000

        $display("%b | %b | %b  | %b | %b   || %b   %b", a, b, carryin, sel, negate, out, carryout);
    end

endmodule

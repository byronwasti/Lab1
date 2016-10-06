`timescale 1 ns / 1 ps
`include "alu.v"

module testBitSlice();

    reg a, b, carryin;
    reg [2:0] sel;
    reg invert;

    wire out, carryout;

    bitSliceALU bitslice0 (out, carryout, a, b, carryin, sel, invert);

    initial begin
        $display("a | b | ci | sel | inv || out co");
        a=1;b=1;sel=0;carryin=0;invert=0; #1000
        $display("%b | %b |  %b |   %d |   %b || %b   %b", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;sel=0;carryin=0;invert=1; #1000
        $display("%b | %b |  %b |   %d |   %b || %b   %b", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;sel=0;carryin=1;invert=1; #1000
        $display("%b | %b |  %b |   %d |   %b || %b   %b", a, b, carryin, sel, invert, out, carryout);
        
    end

endmodule

// bit-slice alu testbench

`timescale 1 ns / 1 ps
`include "alu.v"

module testBitSlice();

    reg a, b, carryin;
    reg [2:0] sel;
    reg invert;

    wire outAdder, outAnd, outNand, outNor, outOr, outXor, carryout;

    bitSliceALU bitslice0 (outAdder, outAnd, outNand, outNor, outOr, outXor, carryout, a, b, carryin, invert);

    initial begin
        $display("a b ci inv | add co  and nand nor or  xor | add co  and nand nor or  xor (expected)");

        a=0;b=0;carryin=0;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   0   0   1    1   0   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=1;carryin=0;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   0   0   1    0   1   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=0;carryin=0;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   0   0   1    0   1   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=1;carryin=0;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   1   1   0    0   1   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=0;carryin=1;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=1;carryin=1;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=0;carryin=1;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=1;carryin=1;invert=0; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=0;carryin=0;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=1;carryin=0;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=0;carryin=0;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=1;carryin=0;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=0;carryin=1;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=0;b=1;carryin=1;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   0", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=0;carryin=1;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 1   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
        a=1;b=1;carryin=1;invert=1; #1000
        $display("%b %b %b  %b   | %b   %b   %b   %b    %b   %b   %b   | 0   1", 
            a, b, carryin, invert, outAdder, carryout, outAnd, outNand, outNor, outOr, outXor);
    end

endmodule

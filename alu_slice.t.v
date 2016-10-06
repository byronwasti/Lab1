`timescale 1 ns / 1 ps
`include "alu.v"

module testBitSlice();

    reg a, b, carryin;
    reg [2:0] sel;
    reg invert;

    wire outAdder, outAnd, outNand, outNor, outOr, outXor, carryout;

    bitSliceALU bitslice0 (outAdder, outAnd, outNand, outNor, outOr, outXor, carryout, a, b, carryin, sel, invert);

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars();  

        $display("a b ci sel inv | add and nand nor or xor co | out co (expected)");

        a=0;b=0;carryin=0;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);


        a=0;b=1;carryin=0;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);


        a=1;b=0;carryin=0;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);


        a=1;b=1;carryin=0;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);


        a=0;b=0;carryin=1;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);
        $dumpflush;


        a=0;b=1;carryin=1;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);
        $dumpflush;


        a=1;b=1;carryin=1;sel=0;invert=0; #1000
        $display("%b %b %b  %d   %b   | %b   %b   %b    %b   %b  %b   %b  | 0   1", 
            a, b, carryin, sel, invert,
            outAdder, outAnd, outNand, outNor, outOr, outXor, carryout);
        $dumpflush;
    end

endmodule

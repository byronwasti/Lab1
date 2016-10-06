`timescale 1 ns / 1 ps
`include "alu.v"

module testBitSlice();

    reg a, b, carryin;
    reg [2:0] sel;
    reg invert;

    wire out, carryout;

    bitSliceALU bitslice0 (out, carryout, a, b, carryin, sel, invert);

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars();  

        $display("ADD/SUB");
        $display("a b ci sel inv | out co | out co (expected)");
        a=1;b=1;carryin=0;sel=0;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   1", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=0;sel=0;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   0", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=0;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   1", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=0;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   1", a, b, carryin, sel, invert, out, carryout);

        $display("AND");
        $display("a b ci sel inv | out co | out co (expected)");
        a=0;b=0;carryin=0;sel=1;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=0;b=1;carryin=0;sel=1;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=1;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=1;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);

        $display("NAND");
        $display("a b ci sel inv | out co | out co (expected)");
        a=0;b=0;carryin=0;sel=2;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=0;b=1;carryin=0;sel=2;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=2;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=2;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);

        $display("NOR");
        $display("a b ci sel inv | out co | out co (expected)");
        a=0;b=0;carryin=0;sel=3;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=0;b=1;carryin=0;sel=3;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=3;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=3;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);

        $display("OR");
        $display("a b ci sel inv | out co | out co (expected)");
        a=0;b=0;carryin=0;sel=4;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=0;b=1;carryin=0;sel=4;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=4;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=4;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);

        $display("XOR");
        $display("a b ci sel inv | out co | out co (expected)");
        a=0;b=0;carryin=0;sel=5;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=0;b=1;carryin=0;sel=5;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=5;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=5;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);

        $display("SLT");
        $display("a b ci sel inv | out co | out co (expected)");
        a=0;b=0;carryin=0;sel=6;invert=0; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=0;b=1;carryin=0;sel=6;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 1   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=0;carryin=1;sel=6;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        a=1;b=1;carryin=1;sel=6;invert=1; #1000
        $display("%b %b  %b   %d   %b |   %b  %b | 0   X", a, b, carryin, sel, invert, out, carryout);
        
        $dumpflush;
    end

endmodule

`timescale 1 ns / 1 ps
`include "basicBinary.v"

module testBasicBinary();
    reg a;
    reg b;

    wire outAnd;
    wire outNand;
    wire outNor;
    wire outOr;
    wire outXor;

    aluAND submodule_AND   (outAnd, a, b);
    aluNAND submodule_NAND (outNand, a, b);
    aluNOR submodule_NOR   (outNor, a, b);
    aluOR submodule_OR     (outOr, a, b);
    aluXOR submodule_XOR   (outXor, a, b);

    initial begin
        $display("Testing basic logic gates");
        $display("a | b || AND | NAND | OR | NOR | XOR | Expected");
        $display("--|---||-----|------|----|-----|-----|---------");

        a = 0;
        b = 0;
        #1000
        $display("%b | %b || %b   | %b    | %b  | %b   | %b   | 0 1 0 1 0",
                  a, b, outAnd, outNand, outOr, outNor, outXor);

        a = 1;
        b = 0;
        #1000
        $display("%b | %b || %b   | %b    | %b  | %b   | %b   | 0 1 1 0 1",
                  a, b, outAnd, outNand, outOr, outNor, outXor);

        a = 0;
        b = 1;
        #1000
        $display("%b | %b || %b   | %b    | %b  | %b   | %b   | 0 1 1 0 1",
                  a, b, outAnd, outNand, outOr, outNor, outXor);

        a = 1;
        b = 1;
        #1000
        $display("%b | %b || %b   | %b    | %b  | %b   | %b   | 1 0 1 0 0",
                  a, b, outAnd, outNand, outOr, outNor, outXor);

    end

endmodule

`include "adder.v"
`include "mux.v"
`include "lut.v"

`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #50
`define NAND nand #20
`define NOR nor #20

module bitSliceALU
(
    output outAdder,
    output outAnd,
    output outNand,
    output outNor,
    output outOr,
    output outXor,
    output carryout,
    input a,
    input b,
    input carryin,
    input [2:0] sel,
    input invert
);
    wire a, b, carryin, invert;

    wire [7:0] outputs;
    wire invertB;

    `XOR xorgate1 (invertB, invert, b);
    fullAdder adder0 (outAdder, carryout, a, invertB, carryin);
    `AND andgate0 (outAnd,  a, b);
    `NAND nandgate0 (outNand, a, b);
    `NOR norgate0 (outNor, a, b);
    `OR orgate0 (outOr, a, b);
    `XOR xorgate0 (outXor, a, b);

endmodule


module alu
(
    output [31:0] out,
    output overflow,
    input [2:0] operation,
    input [31:0] a,
    input [31:0] b
);

    wire [31:0] carryoutSlice;

    wire [2:0] sel;
    wire invert;
    wire initialOverflow;
    wire sltOp;
    aluLUT lut0 (sel, invert, operation);

    wire [31:0] outAdder;
    wire [31:0] outAnd;
    wire [31:0] outNand;
    wire [31:0] outNor;
    wire [31:0] outOr;
    wire [31:0] outXor;
    wire [31:0] outSlt;

    bitSliceALU _alu(outAdder[0], outAnd[0], outNand[0],
                     outNor[0], outOr[0], outXor[0],
                     carryoutSlice[0], a[0], b[0], 
                     invert, sel, invert); // Carry-in at first is invert

    aluMUX _mux(out[0], sel, outAdder[0], outAnd[0], outNand[0],
                                      outNor[0], outOr[0], outXor[0], outSlt[0], outSlt[0]);

    genvar i;
    generate
        for (i=1; i < 32; i=i+1) begin : aluSlices
            bitSliceALU _alu(outAdder[i], outAnd[i], outNand[i], 
                             outNor[i], outOr[i], outXor[i], 
                             carryoutSlice[i], a[i], b[i], 
                             carryoutSlice[i-1], sel, invert);
            aluMUX _mux(out[i], sel, outAdder[i], outAnd[i], outNand[i],
                                      outNor[i], outOr[i], outXor[i], outSlt[i], outSlt[i]);
        end
    endgenerate

    // Handle overflow logic
    `XOR xorgate0 (initialOverflow, carryoutSlice[30], carryoutSlice[31]);
    
    // Only propagate overflow if an add or subtract
    wire [2:0] notSel;
    `NOT (notSltOp, sltOp);
    `NOT (notSel[0], sel[0]);
    `NOT (notSel[1], sel[1]);
    `NOT (notSel[2], sel[2]);
    `AND (overflow, initialOverflow, notSel[0], notSel[1], notSel[2]);

    // Overflow is used to determine SLT
    `XOR (outSlt[0], initialOverflow, outAdder[31]);

endmodule

// alu circuit (both bit-slice and 32-bit)

// include submodules
`include "adder.v"
`include "mux.v"
`include "lut.v"

// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #50
`define NAND nand #20
`define NOR nor #20

// bit-slice ALU
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
    input invert
);
    wire a, b, carryin, invert;
    wire binv;

    // set each output
    `XOR xorgate1 (binv, invert, b);
    fullAdder adder0 (outAdder, carryout, a, binv, carryin);
    `AND andgate0 (outAnd,  a, b);
    `NAND nandgate0 (outNand, a, b);
    `NOR norgate0 (outNor, a, b);
    `OR orgate0 (outOr, a, b);
    `XOR xorgate0 (outXor, a, b);
endmodule

// main 32-bit alu
module ALU
(
    output [31:0] result,
    output carryout,
    output zero,
    output overflow,
    input [31:0] operandA,
    input [31:0] operandB,
    input [2:0] command
);
    // inputs
    wire [31:0] operandA, operandB;
    wire [2:0] command;

    // LUT
    wire [2:0] sel;
    wire invert;
    aluLUT lut0 (sel, invert, command);

    // outputs for bit-slice
    wire [31:0] outAdder, outAnd, outNand, outNor, outOr, outXor, outSlt;
    wire [31:0] carryoutSlice;

    // compute outputs and mux for each bit using bit-slice
    bitSliceALU _alu(outAdder[0], outAnd[0], outNand[0],
                     outNor[0], outOr[0], outXor[0],
                     carryoutSlice[0], operandA[0], operandB[0], 
                     invert, invert); // Carry-in at first is invert
    aluMUX _mux(result[0], sel, outAdder[0], outAnd[0], outNand[0],
                                      outNor[0], outOr[0], outXor[0], outSlt[0], 1'b0);
    genvar i;
    generate
        for (i=1; i < 32; i=i+1) begin : aluSlices
            bitSliceALU _alu(outAdder[i], outAnd[i], outNand[i], 
                             outNor[i], outOr[i], outXor[i],
                             carryoutSlice[i], operandA[i], operandB[i], 
                             carryoutSlice[i-1], invert);
            aluMUX _mux(result[i], sel, outAdder[i], outAnd[i], outNand[i],
                                      outNor[i], outOr[i], outXor[i], 1'b0, 1'b0);
        end
    endgenerate

    // handle overflow logic
    wire initialOverflow;
    `XOR xorgate0 (initialOverflow, carryoutSlice[30], carryoutSlice[31]);
    
    // only propagate carryout and overflow if an add or subtract
    wire sltOp;
    wire [2:0] notSel;
    `NOT (notSltOp, sltOp);
    `NOT (notSel[0], sel[0]);
    `NOT (notSel[1], sel[1]);
    `NOT (notSel[2], sel[2]);
    // more delay because 4-input AND built from two NANDs and one NOR
    and #40 (carryout, carryoutSlice[31], notSel[0], notSel[1], notSel[2]);
    and #40 (overflow, initialOverflow, notSel[0], notSel[1], notSel[2]);

    // determine SLT taking overflow into account
    `XOR (outSlt[0], initialOverflow, outAdder[31]);

    // set zero flag
    wire [30:0] ors;
    `OR (ors[0], result[0], result[1]);
    generate
        for (i=0; i < 30; i=i+1) begin : calcZero
            `OR (ors[i+1], result[i+1], ors[i]);
        end
    endgenerate
    `NOT (zero, ors[30]);

endmodule

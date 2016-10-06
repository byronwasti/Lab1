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
    output out,
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
    fullAdder adder0 (outputs[0], carryout, a, invertB, carryin);
    `AND andgate0 (outputs[1],  a, b);
    `NAND nandgate0 (outputs[2], a, b);
    `NOR norgate0 (outputs[3], a, b);
    `OR orgate0 (outputs[4], a, b);
    `XOR xorgate0 (outputs[5], a, b);

    aluMUX mux0 (out, sel, outputs);

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
    aluLUT lut0 (sel, invert, sltOp, operation);

    bitSliceALU _alu(out[0], carryoutSlice[0], a[0], b[0], invert, sel, invert);
    genvar i;
    generate
        for (i=1; i < 32; i=i+1) begin : aluSlices
            bitSliceALU _alu(out[i], carryoutSlice[i], a[i], b[i], carryoutSlice[i-1], sel, invert);
        end
    endgenerate


    // Handle overflow logic
    `XOR xorgate0 (initialOverflow, carryoutSlice[30], carryoutSlice[31]);
    
    // Only propagate overflow if an add or subtract
    wire notSltOp;
    wire [2:0] notSel;
    `NOT (notSltOp, sltOp);
    `NOT (notSel[0], sel[0]);
    `NOT (notSel[1], sel[1]);
    `NOT (notSel[2], sel[2]);
    `AND (overflow, initialOverflow, notSel[0], notSel[1], notSel[2], notSltOp);

    // Overflow is used to determine SLT
    wire sltWire;
    `XOR (sltWire, initialOverflow, out[31]);


endmodule

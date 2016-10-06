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
    input negate
);
    wire a, b, carryin, negate;

    wire [7:0] outputs;
    wire invertB;

    `AND andgate0 (outputs[0],  a, b);
    `NOR norgate0 (outputs[1], a, b);
    `OR orgate0 (outputs[2], a, b);
    `XOR xorgate0 (outputs[3], a, b);
    `NAND nandgate0 (outputs[4], a, b);
    
    `XOR xorgate1 (invertB, negate, b);

    fullAdder adder0 (outputs[5], carryout, a, invertB, carryin);

    aluMUX mux0 (out, sel, outputs);

endmodule


module alu
(
    output [31:0] out,
    output overflow,
    input [2:0] operation,
    input [31:0] a,
    input [31:0] b,
);

    wire [31:0] outSlice;
    wire [31:0] carryoutSlice;

    wire [2:0] sel;
    wire invert;
    aluLUT lut0 (sel, invert, operation);

    bitSliceALU _alu(outSlice[0], carryoutSlice[0], a[0], b[0], sel, invert);
    genvar i;
    generate
        for (i=1; i < 32; i=i+1) begin : ADDER
            bitSliceALU _alu(outSlice[i], carryoutSlice[i], a[i], b[i], carryoutSlice[i-1], sel, invert);
        end
    endgenerate

endmodule

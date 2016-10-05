`include "adder.v"
`include "basicBinary.v"
`include "mux.v"

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

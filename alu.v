`include "adder.v"
`include "basicBinary.v"
`include "mux.v"

`define XOR xor #50

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

    aluAND andgate0 (outputs[0],  a, b);
    aluNOR norgate0 (outputs[1], a, b);
    aluOR orgate0 (outputs[2], a, b);
    aluXOR xorgate0 (outputs[3], a, b);
    aluNAND nandgate0 (outputs[4], a, b);
    
    `XOR xorgate1 (invertB, negate, b);

    fullAdder adder0 (outputs[5], carryout, a, invertB, carryin);

    aluMUX mux0 (out, sel, outputs);

endmodule

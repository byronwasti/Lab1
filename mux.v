`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #50
`define NAND nand #20
`define NOR nor #20

module aluMUX
    /*
    * 8:1 MUX
    */
(
    output out,
    input [2:0] sel,
    input [7:0] inputs
);
    
    wire [7:0] preOut;
    wire [2:0] notSel;

    `NOT (notSel[0], sel[0]);
    `NOT (notSel[1], sel[1]);
    `NOT (notSel[2], sel[2]);

    `AND andgate0 (preOut[0], inputs[0], notSel[2], notSel[1], notSel[0]);
    `AND andgate1 (preOut[1], inputs[1], notSel[2], notSel[1], sel[0]);
    `AND andgate2 (preOut[2], inputs[2], notSel[2], sel[1], notSel[0]);
    `AND andgate3 (preOut[3], inputs[3], notSel[2], sel[1], sel[0]);
    `AND andgate4 (preOut[4], inputs[4], sel[2], notSel[1], notSel[0]);
    `AND andgate5 (preOut[5], inputs[5], sel[2], notSel[1], sel[0]);
    `AND andgate6 (preOut[6], inputs[6], sel[2], sel[1], notSel[0]);
    `AND andgate7 (preOut[7], inputs[7], sel[2], sel[1], sel[0]);

    `OR orgate0 (out, preOut[0], preOut[1], preOut[2], preOut[3], preOut[4], preOut[5], preOut[6], preOut[7]);

endmodule

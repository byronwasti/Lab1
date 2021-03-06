// 8:1 mux circuit

// define gates with delays
`define AND and #40 // 4-input AND built from two NANDs and one NOR
`define OR or #70   // 8 input OR built from two NORS, one NAND, and an OR
`define NOT not #10

module aluMUX
(
    output out,
    input [2:0] sel,
    input input0,
    input input1,
    input input2,
    input input3,
    input input4,
    input input5,
    input input6,
    input input7
);
    // inputs
    wire [2:0] sel;
    wire input0, input1, input2, input3, input4, input5, input6, input7;

    // intermediate values
    wire [7:0] preOut;
    wire [2:0] notSel;
    `NOT (notSel[0], sel[0]);
    `NOT (notSel[1], sel[1]);
    `NOT (notSel[2], sel[2]);

    // mux logic
    `AND andgate0 (preOut[0], input0, notSel[2], notSel[1], notSel[0]);
    `AND andgate1 (preOut[1], input1, notSel[2], notSel[1], sel[0]);
    `AND andgate2 (preOut[2], input2, notSel[2], sel[1], notSel[0]);
    `AND andgate3 (preOut[3], input3, notSel[2], sel[1], sel[0]);
    `AND andgate4 (preOut[4], input4, sel[2], notSel[1], notSel[0]);
    `AND andgate5 (preOut[5], input5, sel[2], notSel[1], sel[0]);
    `AND andgate6 (preOut[6], input6, sel[2], sel[1], notSel[0]);
    `AND andgate7 (preOut[7], input7, sel[2], sel[1], sel[0]);
    `OR orgate0 (out, preOut[0], preOut[1], preOut[2], preOut[3], preOut[4], preOut[5], preOut[6], preOut[7]);

endmodule

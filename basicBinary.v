`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #50
`define NAND nand #20
`define NOR nor #20

module aluAND
(
    output out,
    input a,
    input b
);
    
    `AND andgate0 (out, a, b);

endmodule


module aluNAND
(
    output out,
    input a,
    input b
);
    
    `NAND nandgate0 (out, a, b);

endmodule


module aluNOR
(
    output out,
    input a,
    input b
);
    
    `NOR norgate0 (out, a, b);

endmodule


module aluOR
(
    output out,
    input a,
    input b
);
    
    `OR orgate0 (out, a, b);

endmodule


module aluXOR
(
    output out,
    input a,
    input b
);
    
    `XOR orgate0 (out, a, b);

endmodule


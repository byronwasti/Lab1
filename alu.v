// main ALU circuit

// include submodules
`include "adder.v"
`include "basicBinary.v"
// `include "mux.v"

// define logic control
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALU
(
    output[31:0]    result,
    output          carryout,
    output          zero,
    output          overflow,
    input[31:0]     operandA,
    input[31:0]     operandB,
    input[2:0]      command
);
    wire [2:0]  muxindex;
    wire        invert;
    wire        command;
    wire[31:0]  operandA;
    wire[31:0]  operandB;
    wire[31:0]  allcarryouts;

    wire[31:0]  result;
    wire        carryout;
    wire        zero;
    wire        overflow;

    ALUcontrolLUT lut (muxindex, invert, command);

    fullAdder adder (result[0], allcarryouts[0], operandA[0], operandB[0], 'b0)
    for (i=1;i<32;i=i+1) begin
        fullAdder adder (result[i], allcarryouts[i], operandA[i], operandB[i], allcarryouts[i-1]);
    end
    carryout = allcarryouts[31];
    xor #50 xorgate (overflow, allcarryouts[30], carryout);

endmodule

module ALUcontrolLUT
(
    output reg[2:0] muxindex,
    output reg      invert,
    input[2:0]      ALUcommand
)

  always @(ALUcommand) begin
    case (ALUcommand)
        `ADD:  begin muxindex = 0; invert=0; end    
        `SUB:  begin muxindex = 0; invert=1; end
        `AND:  begin muxindex = 1; invert=1; end
        `NAND: begin muxindex = 1; invert=0; end
        `NOR:  begin muxindex = 2; invert=0; end
        `OR:   begin muxindex = 2; invert=1; end
        `XOR:  begin muxindex = 3; invert=0; end
        // `SLT:  begin muxindex = 2; invert=0; end   
    endcase
  end
endmodule
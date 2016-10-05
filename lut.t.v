`timescale 1 ns / 1 ps
`include "lut.v"

module testLUT();
    reg [2:0] op;

    wire [2:0] sel;
    wire negate;

    aluLUT aluLUT0 (sel, negate, op);

    initial begin
        $display("sel negate op");
    end
endmodule

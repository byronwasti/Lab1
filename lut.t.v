`timescale 1 ns / 1 ps
`include "lut.v"

module testLUT();
    reg [2:0] cmd;

    wire [2:0] sel;
    wire invert;

    aluLUT aluLUT0 (sel, invert, cmd);

    initial begin
        $display("cmd | sel invert");
        cmd = `ADD;
        $display("  %b |   %b      %b | 0 0", cmd, sel, invert);
    end
endmodule

// Set Less Then testbench
`timescale 1 ns / 1 ps
`include "slt.v"

module testSLT();
    reg[31:0] a, b;
    wire boolean;

    SLTcircuit setLessThan (boolean, a, b);

    initial begin
    // $dumpfile("slt.vcd");
    // $dumpvars();
    $display("A B | LT?");
    a=1;b=0; #500
    $display("%b %b | %b", a, b, boolean);
    a=1;b=1; #500 
    $display("%b %b | %b", a, b, boolean);
    a=0;b=1; #500
    $display("%b %b | %b", a, b, boolean);
    a=0;b=32'b11111111111111111111111111111111; #500
    $display("%b %b | %b", a, b, boolean);
    a=32'b11111111111111111111111111111111;b=0; #500
    $display("%b %b | %b", a, b, boolean);
    a=32'b1111111111;b=32'b1111111111; #500
    $display("%b %b | %b", a, b, boolean);
    a=32'b11111111;b=32'b1111; #500
    $display("%b %b | %b", a, b, boolean);
    a=32'b1010101010101000;b=32'b10101010; #500
    $display("%b %b | %b", a, b, boolean);
    end
endmodule

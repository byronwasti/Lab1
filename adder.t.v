// Adder testbench
`timescale 1 ns / 1 ps
`include "adder.v"

module testFullAdder();
    reg a, b, carryin;
    wire sum, carryout;

    fullAdder adder (sum, carryout, a, b, carryin);

    initial begin
    // $dumpfile("adder.vcd");
    // $dumpvars();
    $display("A  B  CI | Sum CO | Sum CO (Expected Output)");
    a=0;b=0;carryin=0; #500 
    $display("%b  %b  %b  |   %b  %b | 0   0", a, b, carryin, sum, carryout);
    a=1;b=0;carryin=0; #500
    $display("%b  %b  %b  |   %b  %b | 1   0", a, b, carryin, sum, carryout);
    a=0;b=1;carryin=0; #500 
    $display("%b  %b  %b  |   %b  %b | 1   0", a, b, carryin, sum, carryout);
    a=1;b=1;carryin=0; #500 
    $display("%b  %b  %b  |   %b  %b | 0   1", a, b, carryin, sum, carryout);
    a=0;b=0;carryin=1; #500 
    $display("%b  %b  %b  |   %b  %b | 1   0", a, b, carryin, sum, carryout);
    a=1;b=0;carryin=1; #500 
    $display("%b  %b  %b  |   %b  %b | 0   1", a, b, carryin, sum, carryout);
    a=0;b=1;carryin=1; #500 
    $display("%b  %b  %b  |   %b  %b | 0   1", a, b, carryin, sum, carryout);
    a=1;b=1;carryin=1; #500 
    $display("%b  %b  %b  |   %b  %b | 1   1", a, b, carryin, sum, carryout);
    // $dumpflush;
    end
endmodule
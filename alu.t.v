`timescale 1 ns / 1 ps
`include "alu.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module testALU();
    
    reg signed [31:0] a;
    reg signed [31:0] b;
    reg[2:0] operation;

    wire signed [31:0] out;
    wire overflow;

    alu alu0(out, overflow, operation, a, b);

    initial begin
        // $dumpfile("alu_all.vcd");
        // $dumpvars();  
        $display("a            b            op  | out          overflow | expected");
        a=-32'd2147483000;b=32'd483001;operation=`ADD; #100000;
        $display("%-11d  %-11d  ADD | %-11d  %b", a, b, out, overflow);
        a=32'd2147483000;operation=`SUB; #100000;
        $display("%-11d  %-11d  SUB | %-11d  %b", a, b, out, overflow);

        $display();
        $display("a                                 b                                 op   | out                               overflow | expected");
        a=32'b10101010101010101111000011110000;b=32'b01010101010101010000111111110000;operation=`AND; #100000;
        $display("%b  %b  AND  | %b  %b", a, b, out, overflow);
        operation=`NAND; #100000;
        $display("%b  %b  NAND | %b  %b", a, b, out, overflow);
        operation=`OR; #100000;
        $display("%b  %b  OR   | %b  %b", a, b, out, overflow);
        operation=`NOR; #100000;
        $display("%b  %b  NOR  | %b  %b", a, b, out, overflow);
        operation=`XOR; #100000;
        $display("%b  %b  XOR  | %b  %b", a, b, out, overflow);

        $display();
        $display("a            b            op  | out overflow | expected");
        a=-32'd2147483000;b=32'd483001;operation=`SLT; #100000;
        $display("%-11d  %-11d  SLT | %0d   %b", a, b, out, overflow);
        a=32'd2147483000; #100000;
        $display("%-11d  %-11d  SLT | %0d   %b", a, b, out, overflow);

        // $dumpflush;
    end

endmodule


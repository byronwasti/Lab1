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
    
    reg[31:0] a;
    reg[31:0] b;
    reg[2:0] operation;

    wire[31:0] out;
    wire overflow;

    alu alu0(out, overflow, operation, a, b);

    initial begin
        $dumpfile("alu_all.vcd");
        $dumpvars();  
        $display("a  b  op | out overflow | Expected");
        
        //a=32'd10;
        //b=32'd13;
        a=32'd2;
        b=32'd1;
        operation=`AND;
        #100000;
        $display("%d %d %b | %d %b | 15 0", a, b, operation, $signed(out), overflow);

        $dumpflush;
    end

endmodule


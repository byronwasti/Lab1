`include "mux.v"

module testMux();
    reg[2:0] sel;
    reg[7:0] muxInputs;

    wire out;

    aluMUX mux0 (out, sel, muxInputs);

    initial begin
        $display("Testing multiplexer");

        sel=0;
        muxInputs[1]=0;
        #1000
        $display("%b", out);
    end
    
endmodule

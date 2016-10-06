CC=iverilog
OUT=run

all:
	echo "make {adder, alu, lut, mux, slt, clean}"

adder: adder.v adder.t.v
	$(CC) adder.t.v && ./a.out

alu: alu.v alu.t.v
	$(CC) alu.t.v && ./a.out

aluSlice: alu.v alu_slice.t.v
	$(CC) alu_slice.t.v && ./a.out

lut: lut.v lut.t.v
	$(CC) lut.t.v && ./a.out

mux: mux.v mux.t.v
	$(CC) mux.t.v && ./a.out

slt: slt.v slt.t.v
	$(CC) slt.t.v && ./a.out


clean:
	rm -r $(OUT)

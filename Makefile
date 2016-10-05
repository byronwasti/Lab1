CC=iverilog
OUT=run

all:
	echo "make {adder, alu, lut, mux, slt, clean}"

adder: adder.v adder.t.v
	$(CC) adder.t.v -o $(OUT)

alu: alu.v alu.t.v
	$(CC) alu.t.v -o $(OUT)

lut: lut.v lut.t.v
	$(CC) lut.t.v -o $(OUT)

mux: mux.v mux.t.v
	$(CC) mux.t.v -o $(OUT)

slt: slt.v slt.t.v
	$(CC) slt.t.v -o $(OUT)


clean:
	rm -r $(OUT)

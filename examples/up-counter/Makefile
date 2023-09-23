EXAMPLE=upcounter
BIN=$(EXAMPLE).out

compile: $(BIN)

run:
	vvp -v $(BIN)

display-waveform:
	gtkwave $(EXAMPLE).vcd

$(BIN): testbench-$(EXAMPLE).sv $(EXAMPLE).sv
	iverilog -o $@ $^

clean:
	rm --verbose $(BIN)

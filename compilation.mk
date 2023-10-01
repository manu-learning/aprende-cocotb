SOURCE_FILES=$(wildcard *.v)
EXAMPLE_NAME=$(notdir $(PWD))
BIN=$(EXAMPLE_NAME).out

compile: $(BIN)

test:
	@echo $(EXAMPLE_NAME)

# (vvp) Icarus verilog vvp runtime engine
# ---------------------------------------
#
# - ejecuta el compilador por Icarus Verilog
run:
	vvp -v $(BIN)

display-waveform:
	gtkwave $(EXAMPLE_NAME).vcd

# (iverilog) Icarus Verilog Compiler
# ----------------------------------
#
# - compila el código fuente de archivos .v
$(BIN): $(SOURCE_FILES)
	iverilog -o $@ $^

clean:
	@rm --verbose *.out
	@rm --verbose *.vcd

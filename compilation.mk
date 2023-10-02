VERILOG_SOURCE_FILES=$(wildcard $(VERILOG_SOURCE_CODE_DIR)/*.v)
TESTBENCH_FILES=$(wildcard $(TESTBENCH_DIR)/*.v)

EXAMPLE_NAME=$(notdir $(PWD))
SIMULATION_FILE=$(EXAMPLE_NAME).out

compile: $(SIMULATION_DIR)/$(SIMULATION_FILE)

# (vvp) Icarus verilog vvp runtime engine
# ---------------------------------------
#
# - ejecuta el compilador por Icarus Verilog
run:
	vvp -v $(SIMULATION_DIR)/$(SIMULATION_FILE)

display-waveform:
	gtkwave $(WAVEFORM_DIR)/$(EXAMPLE_NAME).vcd

# (iverilog) Icarus Verilog Compiler
# ----------------------------------
#
# - compila el código fuente de archivos .v
$(SIMULATION_DIR)/$(SIMULATION_FILE): $(VERILOG_SOURCE_FILES) $(TESTBENCH_FILES)
	iverilog -o $@ $^

clean:
	@rm --verbose $(SIMULATION_DIR)/*.out
	@rm --verbose $(WAVEFORM_DIR)/*.vcd

VERILOG_SOURCE_FILES=$(wildcard $(VERILOG_SOURCE_CODE_DIR)/*.v)
VERILOG_TESTBENCH=$(wildcard $(TESTBENCH_DIR)/*.v)

EXAMPLE_NAME=$(notdir $(PWD))
SIMULATION_FILE=$(EXAMPLE_NAME).vvp
SIMULATION_VERILOG_TESTBENCH=$(EXAMPLE_NAME)_tb.vvp

compile: $(SIMULATION_DIR)/$(SIMULATION_FILE)

compile-testbench: $(SIMULATION_DIR)/$(SIMULATION_VERILOG_TESTBENCH)

##@ Acciones Generales (ejecutar dentro de un directorio raíz de un example)
display-waveform: ##
	gtkwave $(WAVEFORM_DIR)/dump.vcd

myclean: ##
	@rm --verbose $(WAVEFORM_DIR)/*.vcd
	@rm --verbose $(SIMULATION_DIR)/*.vvp

# (vvp) Icarus verilog vvp runtime engine
# ---------------------------------------
#
# - ejecuta el compilador por Icarus Verilog

##@ Acciones con Verilog (ejecutar dentro de un directorio raíz de un example)
verilog-run: ##
	vvp -v $(SIMULATION_DIR)/$(SIMULATION_FILE)

verilog-testbench: ## (no confundir con el testbench de cocotb)
	vvp -v $(SIMULATION_DIR)/$(SIMULATION_VERILOG_TESTBENCH)

# (iverilog) Icarus Verilog Compiler
# ----------------------------------
#
# - compila el código fuente de archivos .v

$(SIMULATION_DIR)/$(SIMULATION_VERILOG_TESTBENCH): $(VERILOG_SOURCE_FILES) $(VERILOG_TESTBENCH)
	iverilog -o $@ $^

$(SIMULATION_DIR)/$(SIMULATION_FILE): $(VERILOG_SOURCE_FILES)
	iverilog -o $@ $^

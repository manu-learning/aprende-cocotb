VERILOG_SOURCE_FILES=$(wildcard $(VERILOG_SOURCE_CODE_DIR)/*.v)
VERILOG_TESTBENCH=$(wildcard $(TESTBENCH_DIR)/*.v)

EXAMPLE_NAME=$(notdir $(PWD))
#SIMULATION_FILE=$(EXAMPLE_NAME).vvp
#SIMULATION_VERILOG_TESTBENCH=$(EXAMPLE_NAME)_tb.vvp

SIMULATION_VERILOG_TESTBENCH=sim.vvp
WAVEFORMS_FILENAME=dump.vcd

##@ Acciones Generales (ejecutar dentro de un directorio raíz de un example)
display-waveform: ##
	gtkwave $(WAVEFORM_DIR)/$(WAVEFORMS_FILENAME)

myclean: ##
	@rm --verbose $(WAVEFORM_DIR)/*.vcd
	@rm --verbose $(SIMULATION_DIR)/*.vvp

# (vvp) Icarus verilog vvp runtime engine
# ---------------------------------------
#
# - ejecuta el compilador por Icarus Verilog

##@ Acciones con Verilog (ejecutar dentro de un directorio raíz de un example)
compile-verilog-testbench: $(SIMULATION_DIR)/$(SIMULATION_VERILOG_TESTBENCH)

run-verilog-testbench:
	vvp -v $(SIMULATION_DIR)/$(SIMULATION_VERILOG_TESTBENCH)

verilog-testbench: compile-verilog-testbench run-verilog-testbench ## (Compila->Ejecuta, NO confundir con cocotb)

# (iverilog) Icarus Verilog Compiler
# ----------------------------------
#
# - compila el código fuente de archivos .v

$(SIMULATION_DIR)/$(SIMULATION_VERILOG_TESTBENCH): $(VERILOG_SOURCE_FILES) $(VERILOG_TESTBENCH)
	iverilog -o $@ $^

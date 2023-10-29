VERILOG_SOURCE_FILES=$(wildcard ../hdl/*.v)
COCOTB_TESTBENCH_FILES=$(wildcard ../tests/*.py)

# defaults for cocotb Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# TODO: no lo detectaba
#SIM_ARGS ?= --vcd=dump.vcd

VERILOG_SOURCES += $(VERILOG_SOURCE_FILES)

# name of the toplevel module in your verilog file
TOPLEVEL = $(basename $(notdir $(VERILOG_SOURCE_FILES)))

# basename of the python test file
MODULE = $(basename $(notdir $(COCOTB_TESTBENCH_FILES)))

include $(shell cocotb-config --makefiles)/Makefile.sim

##@ Visualizar resultados de simulaciones
# gtkwave-show-adder-test: ##
# 	gtkwave cocotb/examples/adder/tests/dump.vcd

.PHONY: cocotb-simulate

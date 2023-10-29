VERILOG_SOURCE_FILES=$(wildcard ../hdl/*.v)
COCOTB_TESTBENCH_FILES=$(wildcard ../tests/*.py)

# defaults for cocotb Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

#SIM_ARGS ?= --vcd=dump.vcd
#--vcd=waveform.vcd

VERILOG_SOURCES += $(VERILOG_SOURCE_FILES)

# name of the toplevel module in your verilog file
TOPLEVEL = $(basename $(notdir $(VERILOG_SOURCE_FILES)))

# basename of the python test file
MODULE = $(basename $(notdir $(COCOTB_TESTBENCH_FILES)))

include $(shell cocotb-config --makefiles)/Makefile.sim

##@ Visualizar resultados de simulaciones
# gtkwave-show-adder-test: ##
# 	gtkwave cocotb/examples/adder/tests/dump.vcd

# /usr/bin/iverilog -o sim_build/sim.vvp -D COCOTB_SIM=1 -s up_counter -f sim_build/cmds.f -g2012   ../hdl/up_counter.v
# rm -f results.xml
# MODULE=up_counter_tb TESTCASE= TOPLEVEL=up_counter TOPLEVEL_LANG=verilog \
#          /usr/bin/vvp -M /home/jelou/.local/lib/python3.8/site-packages/cocotb/libs -m libcocotbvpi_icarus   sim_build/sim.vvp
.PHONY: cocotb-simulate

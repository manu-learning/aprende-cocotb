.DEFAULT_GOAL=help

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

CURRENT_DIR=$(shell basename $(CURDIR))

# defaults for cocotb Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(CURRENT_DIR).v

# name of the toplevel module in your verilog file
TOPLEVEL = $(CURRENT_DIR)

# basename of the python test file
MODULE = $(CURRENT_DIR)_tb

include $(shell cocotb-config --makefiles)/Makefile.sim

##@ Acciones
cocotb-tb: sim ##

verilog-tb: ##
	iverilog -o sim_build/sim.vvp $(CURRENT_DIR).v $(CURRENT_DIR)_tb.v \
	&& vvp -v sim_build/sim.vvp

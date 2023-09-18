##@ Simulaciones

cocotb-run-quickstart: ##
	make -C cocotb/examples/doc_examples/quickstart

cocotb-run-adder-tests: ##
	make -C cocotb/examples/adder/tests

cocotb-simulate-icarus: ## simulador por default
	make -C cocotb SIM=icarus

cocotb-simulate-ghdl: ##
	SIM_ARGS=--vcd=dumb.vcd TOPLEVEL_LANG=vhdl make -C cocotb SIM=ghdl 

.PHONY: cocotb-run-adder-test cocotb-simulate-icarus cocotb-simulate-ghdl

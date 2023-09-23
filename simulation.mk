##@ Ejecutar Simulaciones
cocotb-run-quickstart: ##
	make --no-print-directory -C cocotb/examples/doc_examples/quickstart

cocotb-run-adder-test: ##
	make --no-print-directory -C cocotb/examples/adder/tests

cocotb-simulate-icarus: ## simulador por default
	make --no-print-directory -C cocotb SIM=icarus

cocotb-simulate-ghdl: ##
	make --no-print-directory -C cocotb SIM_ARGS=--vcd=simulacion1.vcd TOPLEVEL_LANG=vhdl SIM=ghdl

##@ Visualizar resultados de simulaciones
gtkwave-show-adder-test: ##
	gtkwave cocotb/examples/adder/tests/dump.vcd

.PHONY: cocotb-run-adder-test cocotb-simulate-icarus cocotb-simulate-ghdl

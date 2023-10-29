include ../../helper.mk
include ../../config.cfg
include ../../compilation.mk

EXIT_STATUS=$$?
EXIT_STATUS_SUCCESS=0
EXIT_STATUS_FAILURE=1

VERILOG_CONTAINS_DUMPFILE=$(shell \
	grep -q "ifdef COCOTB_SIM" $(VERILOG_SOURCE_CODE_DIR)/$(EXAMPLE_NAME).v; \
	echo $(EXIT_STATUS)\
)

verilog-waveforms-dumpfile:
ifeq ($(VERILOG_CONTAINS_DUMPFILE),$(EXIT_STATUS_FAILURE))
	echo "Agregando un script al $(EXAMPLE_NAME).v para generar el archivo dump.vcd" \
	&& sed -i -e '/endmodule/{r cocotb-dumpfile.txt' -e 'd}' $(VERILOG_SOURCE_CODE_DIR)/$(EXAMPLE_NAME).v \
	&& sed -i -e "s/REPLACE_WITH_MODULE_NAME/$(EXAMPLE_NAME)/" $(VERILOG_SOURCE_CODE_DIR)/$(EXAMPLE_NAME).v
endif

##@ Acciones con Cocotb (ejecutar dentro de un directorio raíz de un example)
cocotb-testbench: verilog-waveforms-dumpfile ##
	make --directory=tests \
	&& mv tests/dump.vcd waveforms/ \
	&& mv tests/sim_build/sim.vvp simulations/

cocotb-clean: ##
	cd tests/ \
	&& rm --verbose --recursive __pycache__ sim_build \
	&& rm results.xml

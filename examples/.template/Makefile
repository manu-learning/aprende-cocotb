include ../../helper.mk
include ../../config.cfg
include ../../compilation.mk

##@ Acciones con Cocotb (ejecutar dentro de un directorio raíz de un example)
cocotb-testbench: ##
	make --directory=tests \
	&& mv tests/dump.vcd waveforms/ \
	&& mv tests/sim_build/sim.vvp simulations/

cocotb-clean: ##
	cd tests/ \
	&& rm --verbose --recursive __pycache__ sim_build \
	&& rm results.xml

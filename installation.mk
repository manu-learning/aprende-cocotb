##@ Instalar Dependencias

install-all: install-python install-cocotb install-verilog install-ghdl ##

install-python: ##
	sudo aptitude install -y python3 python3-pip \
	&& pip3 install pytest

install-cocotb: ##
	pip install cocotb[bus]

install-verilog: ##
	sudo aptitude install -y iverilog verilator

install-ghdl: ##
	sudo aptitude install -y ghdl

install-gtkwave: ##
	sudo aptitude install -y gtkwave

git-clone-cocotb: ##
	git clone https://github.com/cocotb/cocotb.git

.PHONY: install-all install-ghdl install-python install-cocotb install-gtkwave git-clone-cocotb

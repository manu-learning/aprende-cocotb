LOGISIM_EVOLUTION_VERSION=3.8.0
LOGISIM_EVOLUTION_ARCH=amd64
LOGISIM_EVOLUTION_DEBIAN_FILE=logisim-evolution_$(LOGISIM_EVOLUTION_VERSION)-1_$(LOGISIM_EVOLUTION_ARCH).deb

##@ Instalar Dependencias

install-all: install-loigism install-python install-cocotb install-verilog install-ghdl ##

install-logisim: ##
	sudo aptitude install -y logisim

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

# Nota: otra alternativa sería descargar el .jar, pero genera problemas de compatibilidad entre versiones de (JRE)
install-logisim-evolution:
	cd /tmp \
	&& curl \
		--output $(LOGISIM_EVOLUTION_DEBIAN_FILE) \
		--location https://github.com/logisim-evolution/logisim-evolution/releases/download/v$(LOGISIM_EVOLUTION_VERSION)/$(LOGISIM_EVOLUTION_DEBIAN_FILE) \
	&& sudo dpkg -i /tmp/$(LOGISIM_EVOLUTION_DEBIAN_FILE)
.PHONY: install-all install-logisim install-logisim-evolution install-ghdl install-python install-cocotb install-gtkwave git-clone-cocotb

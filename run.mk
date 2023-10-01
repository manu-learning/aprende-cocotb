##@ Ejecutar
run-logisim: ##
	screen -S logisim -d -m logisim

# TODO: agregar archivo binario en la variable de entorno PATH
# (suponiendo que dpkg siempre lo instala en /opt)
run-logisim-evolution: ##
	screen -S logisim-evolution -d -m /opt/logisim-evolution/bin/logisim-evolution

.PHONY: run-logisim run-logisim-evolution

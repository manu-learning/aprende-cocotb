include config.cfg
include helper.mk
include run.mk
include installation.mk
include simulation.mk

##@ Ejemplos
examples/.template: $(EXAMPLE_DIRS)

$(EXAMPLE_DIRS):
	@mkdir --verbose $@

create-new-example: examples/.template ##
	@read -p "Ingrese el nombre del nuevo ejemplo: " NEW_EXAMPLE_NAME; \
	cp --verbose --recursive $< examples/$${NEW_EXAMPLE_NAME}; \
	touch examples/$${NEW_EXAMPLE_NAME}/$(VERILOG_SOURCE_CODE_DIR)/$${NEW_EXAMPLE_NAME}.v; \
	touch examples/$${NEW_EXAMPLE_NAME}/$(TESTBENCH_DIR)/$${NEW_EXAMPLE_NAME}_tb.v

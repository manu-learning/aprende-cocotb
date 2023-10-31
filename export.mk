EXAMPLES=$(wildcard examples/*/)

EXAMPLES_NAMES:=$(subst examples/,,$(EXAMPLES))

# TODO: no es muy eficiente..
EXAMPLES_NAMES:=$(subst /,,$(EXAMPLES_NAMES))

DIR= ~/Documents/git/utn-ba-sat-intro/rtl

export:
	@$(foreach EXAMPLE,$(EXAMPLES_NAMES),\
		mkdir --verbose --parents $(DIR)/$(EXAMPLE); \
		mkdir --verbose --parents $(DIR)/$(EXAMPLE)/waveforms; \
		cp --verbose examples/$(EXAMPLE)/hdl/$(EXAMPLE).v $(DIR)/$(EXAMPLE); \
		cp --verbose examples/$(EXAMPLE)/tests/$(EXAMPLE)_tb.v $(DIR)/$(EXAMPLE); \
		cp --verbose examples/$(EXAMPLE)/tests/$(EXAMPLE)_tb.py $(DIR)/$(EXAMPLE); \
		cp --verbose cocotb-minimal.mk $(DIR)/$(EXAMPLE)/Makefile; \
)

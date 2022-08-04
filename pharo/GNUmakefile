PROJECT=MachineArithmetic

include GNUmakefile.local

# Pharo version to use. Currently, only 8.0 is supported,
# Pharo 9.0 and later is known to crash when using Z3.
PHARO_VERSION ?= 80

# Metacello group to load.
GROUP ?= default

all: $(PROJECT).image check

include ../pharo.gmk


$(PROJECT).image: $(PHARO_VM) $(PHARO_IMAGE) ../MachineArithmetic*/*.st
	$(PHARO_VM_HEADLESS) $(PHARO_IMAGE) save $(shell pwd)/$(PROJECT)
	$(PHARO_VM_HEADLESS) $@ eval --save "(IceRepositoryCreator new location: '..' asFileReference; createRepository) register" || rm $@
	$(PHARO_VM_HEADLESS) $@ metacello install tonel://.. BaselineOf$(PROJECT) --groups=$(GROUP) || rm $@
	@echo ""
	@echo "To open Pharo $(PROJECT) image run:"
	@echo ""
	@echo "    $(PHARO_VM) $(PROJECT).image"
	@echo ""

check:: check-deps

check-deps: $(PROJECT).image $(PHARO_VM)
	$(PHARO_VM_HEADLESS) $< check-deps.st

test: $(PROJECT).image $(PHARO_VM)
	$(PHARO_VM_HEADLESS) $< test --fail-on-failure "$(PROJECT).*Tests.*"

clean:
	rm -f $(PROJECT).image $(PROJECT).changes test-reports *.fuel
	rm -rf pharo-local

mrproper:: clean

GNUmakefile.local::
	@echo "# Local tunables. There's no need to change anything," >> $@
	@echo "# suitable defaults are provided." >> $@
	@echo "" >> $@
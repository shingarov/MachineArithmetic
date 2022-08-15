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
	$(PHARO_VM_HEADLESS) $(PHARO_IMAGE) save $(dir $(abspath $(firstword $(MAKEFILE_LIST))))/$(PROJECT)
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

ifndef Z3_SOURCE_DIR
Z3_SOURCE_DIR=error-Z3-SOURCE-not-defined

error-Z3-SOURCE-not-defined:
	$(error "Z3_SOURCE_DIR variable not defined! Use: $(MAKE) Z3_SOURCE_DIR=/path/to/z3/source update-Z3-API")
endif

LibZ3-generated.st: ../apigen.py | $(Z3_SOURCE_DIR)
	python3 ../apigen.py --pharo --z3-source $(Z3_SOURCE_DIR) > $@

update-Z3-API: $(PROJECT).image $(PHARO_VM) LibZ3-generated.st update-Z3-API.st
	$(PHARO_VM_HEADLESS) $< update-Z3-API.st

clean:
	rm -f $(PROJECT).image $(PROJECT).changes test-reports *.fuel
	rm -rf pharo-local
	rm -f LibZ3-generated.st

mrproper:: clean

GNUmakefile.local::
	@echo "# Local tunables. There's no need to change anything," >> $@
	@echo "# suitable defaults are provided." >> $@
	@echo "" >> $@
	@echo "# Path to Z3 sources, *ONLY* needed for regenerating FFI." >> $@
	@echo "# See comment in ../apigen.py" >> $@
	@echo "# Z3_SOURCE_DIR=../../z3" >> $@
	@echo "" >> $@
PROJECT=MachineArithmetic
GROUP ?= default

all: build

../makefiles/%.gmk:
	git submodule update --init --recursive $(dir $@)

-include GNUmakefile.local
include ../makefiles/pharo.gmk
include ../makefiles/git.gmk

build: prereq $(PROJECT).image check
	@echo ""
	@echo "To open Pharo $(PROJECT) image run:"
	@echo ""
	@echo "    make run"
	@echo ""


$(PROJECT).image: ../src/*/*.st
	$(call pharo-copy-image, $(PHARO_IMAGE), $@)
	$(call pharo-load-local, $@, $(PROJECT), ../src)

run: build
	$(PHARO_VM) $(PROJECT).image

check:: check-deps

check-deps: $(PROJECT).image $(PHARO_VM)
	$(PHARO_VM_HEADLESS) $< check-deps.st

test: $(PROJECT).image $(PHARO_VM)
	$(PHARO_VM_HEADLESS) $< test --fail-on-failure \
		'PreSmalltalks-Tests' \
		'Z3-Tests' \
		'MathNotation-Tests' \
		'Refinements-Tests' \
		'SpriteLang-Tests' \
		'PLE-Tests'

ifndef Z3_SOURCE_DIR
Z3_SOURCE_DIR=error-Z3-SOURCE-not-defined

error-Z3-SOURCE-not-defined:
	$(error "Z3_SOURCE_DIR variable not defined! Use: $(MAKE) Z3_SOURCE_DIR=/path/to/z3/source update-Z3-API")
endif

LibZ3-generated.st: ../apigen.py | $(Z3_SOURCE_DIR)
	python3 ../apigen.py --pharo --z3-source $(Z3_SOURCE_DIR) > $@ || (rm $@ && false)

update-Z3-API: $(PROJECT).image $(PHARO_VM) LibZ3-generated.st update-Z3-API.st
	$(PHARO_VM_HEADLESS) $< update-Z3-API.st

clean::
	rm -f $(PROJECT).image $(PROJECT).changes
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

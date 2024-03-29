PROJECT=MachineArithmetic

all: build

../makefiles/%.gmk:
	git submodule update --init --recursive $(dir $@)

-include GNUmakefile.local
include ../makefiles/stx.gmk
include ../makefiles/git.gmk

build: prereq
	@echo "To run Smalltalk/X with $(PROJECT) loaded, run:"
	@echo ""
	@echo "    make run"
	@echo ""


run: $(STX)
	$(STX) --package-path ../src --load BaselineOf$(PROJECT)

test: $(STX)
	$(STX) --package-path ../src --load BaselineOf$(PROJECT) --run Builder::ReportRunner -r Builder::TestReport --fail-on-failure -p Z3-Tests

ifndef Z3_SOURCE_DIR
Z3_SOURCE_DIR=error-Z3-SOURCE-not-defined

error-Z3-SOURCE-not-defined:
	$(error "Z3_SOURCE_DIR variable not defined! Use: $(MAKE) Z3_SOURCE_DIR=/path/to/z3/source update-Z3-API")
endif

LibZ3-generated.st: ../apigen.py | $(Z3_SOURCE_DIR)
	python3 ../apigen.py --z3-source $(Z3_SOURCE_DIR) > $@ || (rm $@ && false)

update-Z3-API: $(STX) LibZ3-generated.st update-Z3-API.st
	$(STX) --package-path .. --load BaselineOf$(PROJECT) --execute update-Z3-API.st

clean::
	rm -f *Test.xml
	rm -f LibZ3-generated.st

mrproper:: clean

GNUmakefile.local::
	@echo "# Local tunables. There's no need to change anything," >> $@
	@echo "# suitable defaults are provided." >> $@
	@echo "" >> $@
	@echo "" >> $@
	@echo "# Path to Z3 sources, *ONLY* needed for regenerating FFI." >> $@
	@echo "# See comment in ../apigen.py" >> $@
	@echo "# Z3_SOURCE_DIR=../../z3" >> $@
	@echo "" >> $@

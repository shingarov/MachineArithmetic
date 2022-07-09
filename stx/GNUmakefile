PROJECT=MachineArithmetic

include GNUmakefile.local

all: build

include ../stx.gmk

build: $(STX)
	@echo "To run Smalltalk/X with $(PROJECT) loaded, run:"
	@echo ""
	@echo "    $(STX) --package-path .. --load BaselineOf$(PROJECT)"
	@echo ""
	@echo "or use shortcut:"
	@echo ""
	@echo "    make run"
	@echo ""


run: $(STX)
	$(STX) --package-path .. --load BaselineOf$(PROJECT)

test: $(STX)
	$(STX) --package-path .. --load BaselineOf$(PROJECT) --run Builder::ReportRunner -r Builder::TestReport --fail-on-failure -p $(PROJECT)-Tests

clean:
	rm -rf *Test.xml

mrproper:: clean

GNUmakefile.local::
	@echo "# Local tunables. There's no need to change anything," >> $@
	@echo "# suitable defaults are provided." >> $@
	@echo "" >> $@

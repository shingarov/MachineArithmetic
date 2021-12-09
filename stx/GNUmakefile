PROJECT=MachineArithmetic

include GNUmakefile.local

all: build

ifndef STX
STX=./stx/bin/stx

$(STX):
	wget -O- https://swing.fit.cvut.cz/download/smalltalkx/get-stx.py | python3

mrproper::
	echo "rm -rf stx"

endif

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
	$(STX) --package-path .. --load BaselineOf$(PROJECT) --run Builder::ReportRunner --report=Builder::TestReport --fail-on-failure -p $(PROJECT)-Tests

clean:
	rm -rf *Test.xml

mrproper:: clean

GNUmakefile.local:
		@echo "# Local tunables. There's no need to change anything," >> $@
		@echo "# suitable defaults are provided." >> $@
		@echo "" >> $@
		@echo "# To use local copy Smalltalk/X, set STX to Smalltalk/X startup script." >> $@
		@echo "# If unset (default), Smalltalk/X toy-archive will be automatically downloaded," >> $@
		@echo "# into 'stx' subdirectory." >> $@
		@echo "# STX=stx/bin/stx" >> $@
		@echo "" >> $@


PROJECT=MachineArithmetic

all: $(PROJECT).image

include ../gt.gmk

$(PROJECT).image: $(GT) $(GT_IMAGE) ../MachineArithmetic*/*.st
	$(GT_HEADLESS) $(GT_IMAGE) save $(PROJECT)
	$(GT_HEADLESS) $@ eval --save "(IceRepositoryCreator new location: '..' asFileReference; createRepository) register" || rm $@
	$(GT_HEADLESS) $@ metacello install tonel://.. BaselineOf$(PROJECT) || rm $@
	@echo ""
	@echo "To open GT $(PROJECT) image run:"
	@echo ""
	@echo "    $(GT) --image $(PROJECT).image"
	@echo ""

check::

test: $(PROJECT).image ./bin/GlamorousToolkit-cli
	./bin/GlamorousToolkit-cli $< test --fail-on-failure "$(PROJECT).*Tests.*"

clean:
	rm -f $(PROJECT).image $(PROJECT).changes test-reports *.fuel
	rm -fr pharo-local

mrproper:: clean
	rm gt-extra

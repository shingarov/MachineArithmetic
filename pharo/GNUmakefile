PROJECT=MachineArithmetic

all: pharo-ui $(PROJECT).image check

pharo pharo-ui Pharo.image:
	curl https://get.pharo.org/64/80+vm | bash

$(PROJECT).image: pharo Pharo.image ../MachineArithmetic*/*.st
	./pharo Pharo.image save $(PROJECT)
	./pharo $@ eval --save "(IceRepositoryCreator new location: '..' asFileReference; createRepository) register" || rm $@
	./pharo $@ metacello install tonel://.. BaselineOf$(PROJECT) || rm $@
	@echo ""
	@echo "To open Pharo $(PROJECT) image run:"
	@echo ""
	@echo "    ./pharo-ui $(PROJECT).image"
	@echo ""

check:: check-deps

check-deps: $(PROJECT).image pharo
	./pharo $< check-deps.st


test: $(PROJECT).image pharo
	./pharo $< test --fail-on-failure "$(PROJECT).*Tests.*"

clean:
	rm -f $(PROJECT).image $(PROJECT).changes test-reports *.fuel
	rm -fr pharo-local

mrproper: clean
	rm -rf Pharo* pharo* icon-packs

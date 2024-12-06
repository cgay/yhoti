
DYLAN	?= $${HOME}/dylan

.PHONY: build install test dist clean distclean

build:
	deft update
	deft build yhoti-app

install: build
	mkdir -p $(DYLAN)/bin
	mkdir -p $(DYLAN)/install/yhoti/bin
	mkdir -p $(DYLAN)/install/yhoti/lib
	cp _build/bin/yhoti-app $(DYLAN)/install/yhoti/bin/yhoti
	cp -r _build/lib/lib* $(DYLAN)/install/yhoti/lib/
	ln -s -f $$(realpath $(DYLAN)/install/yhoti/bin/yhoti) $(DYLAN)/bin/yhoti

test:
	deft update
	deft test

dist: distclean install

clean:
	rm -rf _packages
	rm -rf registry
	rm -rf _build
	rm -rf _test
	rm -rf *~

distclean: clean
	rm -rf $(DYLAN)/install/yhoti
	rm -f $(DYLAN)/bin/yhoti

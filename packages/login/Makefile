SRC = login logind
PWD = $(shell pwd)
all	:	prepare $(SRC)
clean:
	rm -rf out
prepare:
	mkdir -p out
$(SRC) :
	cd ../../min && lua CommandLineMinify.lua $(PWD)/$@.lua
	mv $@_min.lua out/$@
install:
	cp out/login ../../out/sbin
	cp out/logind ../../out/etc/init.d

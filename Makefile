
FILES=\
	src/sundown/lib/libsundown.so \
	src/sundown/lib/libsundown.min.h

all: $(FILES)

clean:
	rm -rf deps/* src/sundown/lib/*

test: run-tests
run-tests:
	@LUA_PATH="src/?.lua;src/?/init.lua;" luajit test/sundown_test.lua
	@echo All tests passing

################################################################################
# sundown
################################################################################

deps/sundown:
	git clone --depth 1 https://github.com/vmg/sundown.git $@

deps/sundown/Makefile: deps/sundown

deps/sundown/libsundown.so: deps/sundown/Makefile
	cd deps/sundown && make

deps/sundown/src/html.h: deps/sundown/html/html.h
	cp $+ $@

src/sundown/lib/libsundown.so: deps/sundown/libsundown.so
	cp $+ $@

src/sundown/lib/libsundown.min.h: src/sundown/libsundown.h deps/sundown/src/html.h
	gcc -E $< | grep -v '^ *#' > $@

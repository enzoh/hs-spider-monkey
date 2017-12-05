# File       : Makefile
# Copyright  : Copyright (c) 2017 DFINITY Stiftung. All rights reserved.
# License    : GPL-3
# Maintainer : Enzo Haussecker <enzo@dfinity.org>
# Stability  : Experimental

LIB_DIR = lib
OBJ_DIR = obj

CFLAGS  = -I$(PREFIX)/include/mozjs -I$(PREFIX)/include/mozjs/mozilla

$(LIB_DIR)/libhs_mozilla.a: $(OBJ_DIR)/hs_mozilla.o | $(LIB_DIR)
	ar cr $@ $<

$(LIB_DIR):
	mkdir -p $@

$(OBJ_DIR)/hs_mozilla.o: cbits/hs_mozilla.cpp | $(OBJ_DIR)
	g++ $(CFLAGS) -c -lmozglue -lmozjs -lpthread -o $@ -std=c++11 $<

$(OBJ_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(LIB_DIR)
	rm -rf $(OBJ_DIR)

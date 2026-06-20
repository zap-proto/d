ZAP_CXX_FLAGS=$(shell pkg-config zap --cflags --libs)

ifeq ($(ZAP_CXX_FLAGS),)
$(warning "Warning: pkg-config failed to find compilation configuration for zap.")
$(warning "Falling back to a guess based on the location of the zap executable.")
ZAP_PREFIX=$(shell dirname $(shell which zap))/..
ZAP_CXX_FLAGS=-I $(ZAP_PREFIX)/include -L $(ZAP_PREFIX)/lib -lkj -lzap
endif

CXX=g++
CXX_FLAGS=-std=c++14 $(ZAP_CXX_FLAGS)

ZAPC_DLANG_SOURCES=compiler/src/main/cpp/zapc-dlang.c++

.PHONY: all clean

all: zapc-dlang

clean:
	rm -f zapc-dlang zapc-dlang.exe

zapc-dlang: $(ZAPC_DLANG_SOURCES)
	$(CXX) $(ZAPC_DLANG_SOURCES) $(CXX_FLAGS) -g -o zapc-dlang


MINGW_LIBS=~/src/zap/c++/build-mingw/.libs/libzap.a ~/src/zap/c++/build-mingw/.libs/libkj.a
MINGW_CXX=i686-w64-mingw32-g++
MINGW_FLAGS=-O2 -DNDEBUG -I/usr/local/include -std=c++11 -static -static-libgcc -static-libstdc++
zapc-dlang.exe: $(ZAPC_DLANG_SOURCES)
	$(MINGW_CXX) $(MINGW_FLAGS) $(ZAPC_DLANG_SOURCES) $(MINGW_LIBS) -o zapc-dlang.exe

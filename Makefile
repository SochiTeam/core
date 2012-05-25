CC=g++
CFLAGS=-Wall
LDFLAGS=-shared

all: core

core: obj/Main.o
	$(CC) $(LDFLAGS) obj/Main.o -o out/core.dll

obj/Main.o: src/Main.cpp
	$(CC) $(CFLAGS) src/Main.cpp -o obj/Main.o


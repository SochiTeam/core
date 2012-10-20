# Copyright (C) 2012 Sochi Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CC=g++
SRC=$(wildcard src/*.cpp)
OBJ=$(SRC:.cpp=.o)
OUT=out
CFLAGS=-c -Wall
LDFLAGS=-shared


# Definitions
ifneq (SystemRoot,)
WIN32 := true
SO := dll
else
SO := so
endif

all: core

core: Main.o
	$(CC) $(LDFLAGS) obj/Main.o -o out/core.$(SO)

Main.o:
	$(CC) $(CFLAGS) src/Main.cpp -o obj/Main.o


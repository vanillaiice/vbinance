# Determine the operating system
ifeq ($(OS), Windows_NT)
	OS_TARGET = Windows
else
	OS_TARGET := $(shell uname -s)
endif

# Compile depending on OS
os: $(OS_TARGET)

# Compile for windows
Windows:
	mkdir -p bin/windows
	v -cg -keepc . -os windows -o bin/vext.exe

# Compile for linux
Linux:
	mkdir -p bin/linux
	v -cg -keepc . -os linux -o bin/vext

# Compile for darwin
Darwin:
	echo "Cross compilation for Darwin not supported"

# Compile for all OS
all: Windows Linux Darwin

test:
	v -stats test .

# Makefile for fsort and test

SHELL = cmd
FC := gfortran
FLINKER := $(FC)
ARCH := ar
ARCHFLAGS := -rsc

.PHONY: all
all: libfsort.a

fsort_mod.mod: libfsort.a

libfsort.a: fsort.obj
	@echo Generating archive $@ ...
	$(ARCH) $(ARCHFLAGS) $@ $^

fsort.obj: fsort.f90
	@echo Compiling $@ ...
	$(FC) -o $@ -c $< -I . -static -s

.PNONY: test
test: test.exe

test.exe: test.obj libfsort.a fsort_mod.mod
	@echo Linking $@ ...
	$(FLINKER) -o $@ $< -L . -l fsort -static -s

test.obj: test.f90 fsort_mod.mod
	@echo Compiling $@ ...
	$(FC) -o $@ -c $< -static -s

.PHONY: clean
clean:
	-del *.a *.mod *.obj *.exe 1> NUL 2> NUL

.PHONY: clean_tmp
clean_tmp:
	-del *.obj 1> NUL 2> NUL

.PHONY: clean_test
clean_test:
	-del test.obj *.exe 1> NUL 2> NUL


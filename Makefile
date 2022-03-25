# Makefile for qsort and test

SHELL = cmd
FC := gfortran
FLINKER := $(FC)
ARCH := ar
ARCHFLAGS := -rsc

.PHONY: all
all: libqsort.a

qsort_mod.mod: libqsort.a

libqsort.a: qsort.obj
	@echo Generating archive $@ ...
	$(ARCH) $(ARCHFLAGS) $@ $^

qsort.obj: qsort.f90
	@echo Compiling $@ ...
	$(FC) -o $@ -c $< -static -s

.PNONY: test
test: test.exe

test.exe: test.obj libqsort.a qsort_mod.mod
	@echo Linking $@ ...
	$(FLINKER) -o $@ $< -L . -l qsort -static

test.obj: test.f90 qsort_mod.mod
	@echo Compiling $@ ...
	$(FC) -o $@ -c $< -static -s

.PHONY: clean
clean:
	-del *.a *.mod *.obj *.exe * 1> NUL 2> NUL

.PHONY: clean_tmp
clean_tmp:
	-del *.obj 1> NUL 2> NUL

.PHONY: clean_test
clean_test:
	-del test.obj *.exe 1> NUL 2> NUL


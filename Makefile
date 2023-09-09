HC := ghc
BUILDIR := build
MAIN := Main
SRC := $(wildcard ./*.hs)

build: $(SRC)
	mkdir -p $(BUILDIR) 
	$(HC) --make -odir $(BUILDIR) -hidir $(BUILDIR) -o $(BUILDIR)/$(MAIN) $(MAIN).hs

run: build
	./$(BUILDIR)/$(MAIN)

clean:
	rm -rf $(BUILDIR)
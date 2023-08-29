HC := ghc
BUILDIR := build
MAIN := main

build:
	mkdir -p $(BUILDIR) 
	$(HC) --make -odir $(BUILDIR) -hidir $(BUILDIR) -o $(BUILDIR)/$(MAIN) $(MAIN).hs

run: build
	./$(BUILDIR)/$(MAIN)

clean:
	rm -rf $(BUILDIR)
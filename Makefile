HC := ghc
BUILDIR := build

build:
	mkdir -p $(BUILDIR) 
	$(HC) --make -odir $(BUILDIR) -hidir $(BUILDIR) -o $(BUILDIR)/main main.hs

run: build
	./$(BUILDIR)/main

clean:
	rm -rf $(BUILDIR)
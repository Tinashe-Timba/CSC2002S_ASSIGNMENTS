JAVAC=/usr/bin/MonteCarloMini/javac
.SUFFIXES: .java .class
SRCDIR=src/MonteCarloMini
BINDIR=bin/MonteCarloMini

$(BINDIR)/%.class:$(SRCDIR)/%.java
	$(JAVAC) -d $(BINDIR)/ -cp $(BINDIR) $<


CLASSES= Search.class TerrainArea.class MonteCarloMinimization.class MonteCarloMinimizationParallel.class
CLASS_FILES=$(CLASSES:%.class=$(BINDIR)/%.class)

default: $(CLASS_FILES)

clean:
	rm $(BINDIR)/*.class

run: $(CLASS_FILES)
	java -cp $(BINDIR) MonteCarloMinimizationParallel 100 100 50 50 60 70 100

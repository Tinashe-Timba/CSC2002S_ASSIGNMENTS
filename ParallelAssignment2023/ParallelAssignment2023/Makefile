JAVAC=/usr/bin/javac
JAVA=/usr/bin/java
.SUFFIXES: .java .class
SRCDIR=src/MonteCarloMini
BINDIR=bin


$(BINDIR)/MonteCarloMini/%.class:$(SRCDIR)/%.java
	$(JAVAC) -d $(BINDIR)/ -cp $(BINDIR) -sourcepath $(SRCDIR) $<


CLASSES=  TerrainArea.class SearchParallel.class MonteCarloMinimization.class MonteCarloMinimizationParallel.class
CLASS_FILES=$(CLASSES:%.class=$(BINDIR)/MonteCarloMini/%.class)

default: $(CLASS_FILES)

clean:
	rm  $(BINDIR)/MonteCarloMini/*.class

run: $(CLASS_FILES)

	java -cp $(BINDIR) MonteCarloMini.MonteCarloMinimizationParallel  $(ARGS)
	
JAVAC=/usr/bin/javac
JAVA=/usr/bin/java
.SUFFIXES: .java .class
SRCDIR=src/clubSimulation
BINDIR=bin


$(BINDIR)/clubSimulation/%.class:$(SRCDIR)/%.java
	$(JAVAC) -d $(BINDIR)/ -cp $(BINDIR) -sourcepath $(SRCDIR) $<


CLASSES= PeopleLocation.class GridBlock.class PeopleCounter.class ClubGrid.class Clubgoer.class ClubView.class CounterDisplay.class ClubSimulation.class
CLASS_FILES=$(CLASSES:%.class=$(BINDIR)/clubSimulation/%.class)

default: $(CLASS_FILES)

clean:
	rm  $(BINDIR)/clubSimulation/*.class

run: $(CLASS_FILES)

	java -cp $(BINDIR) clubSimulation.ClubSimulation 
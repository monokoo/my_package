CC?=gcc
BINDIR=/usr/bin

all::	shc serverchan

shc: 
	shc -r -U -v -B -f serverchan.sh

serverchan: serverchan.sh.x.c
	$(CC) -o serverchan serverchan.sh.x.c 

clean:
	rm -f *~ *.o $(TARGETS)

install:
	mkdir -p $(BINDIR)
	cp serverchan $(BINDIR)

uninstall:
	rm -f $(BINDIR)/serverchan


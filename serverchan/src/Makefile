CC?=gcc
BINDIR=/usr/bin

all::	shc serverchan serverchan_trigger

shc: 
	shc -r -U -v -B -f serverchan.sh
	shc -r -U -v -B -f serverchan_trigger.sh

serverchan: serverchan.sh.x.c
	$(CC) -o serverchan serverchan.sh.x.c

serverchan_trigger: serverchan_trigger.sh.x.c
	$(CC) -o serverchan_trigger serverchan_trigger.sh.x.c 
	

clean:
	rm -f *~ *.o $(TARGETS)

install:
	mkdir -p $(BINDIR)
	cp serverchan serverchan_trigger $(BINDIR)

uninstall:
	rm -f $(BINDIR)/serverchan $(BINDIR)/serverchan_trigger


CC?=gcc
BINDIR=/usr/bin

all::	shc aliddns cloudxns dnspod

shc: 
	shc -r -U -v -B -f aliddns.sh
	shc -r -U -v -B -f cloudxns.sh
	shc -r -U -v -B -f dnspod.sh

aliddns: aliddns.sh.x.c
	$(CC) -o aliddns aliddns.sh.x.c 

cloudxns: cloudxns.sh.x.c
	$(CC) -o cloudxns cloudxns.sh.x.c

dnspod: dnspod.sh.x.c
	$(CC) -o dnspod dnspod.sh.x.c

clean:
	rm -f *~ *.o $(TARGETS)

install:
	mkdir -p $(BINDIR)
	cp aliddns  cloudxns dnspod $(BINDIR)

uninstall:
	rm -f $(BINDIR)/aliddns $(BINDIR)/cloudxns $(BINDIR)/dnspod


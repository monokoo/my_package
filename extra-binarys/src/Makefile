CC?=gcc
BINDIR=/usr/bin

all::	shc kcpupdate addroute

shc: 
	shc -r -U -v -B -f kcpupdate.sh
	shc -r -U -v -B -f addroute.sh

kcpupdate: kcpupdate.sh.x.c
	$(CC) -o kcpupdate kcpupdate.sh.x.c

addroute: addroute.sh.x.c
	$(CC) -o addroute addroute.sh.x.c 

clean:
	rm -f *~ *.o $(TARGETS)

# install:
	# mkdir -p $(BINDIR)
	# cp kcpupdate $(BINDIR)

# uninstall:
	# rm -f $(BINDIR)/kcpupdate

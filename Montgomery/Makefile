CC = g++
CFLAG = -Wall -g

all: main

%.o: %.c
	$(CC) $(CFLAG) -c -o $@ $<

main: main.o
	$(CC) $(CFLAG) -o $@ $<

clean:
	rm -f *.o main

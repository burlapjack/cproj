#!/bin/bash
main="$1.c"
currentyear=`date +"%Y"`
user=$(whoami)
mkdir $1 && cd $1; mkdir src include bin obj
cat > Makefile << 'EOF'
CC=gcc
CFLAGS=-g -Wall
LIBS=
SRCDIR=src
BINDIR=bin
SRCS=$(wildcard($(SRCDIR)/*.c)
OBJS=$(patsubst $(SRCDIR)/%%.c, $(OBJDIR)/%%.o, $(SRCS))
BIN=$(BINDIR)/$1

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm $(BINDIR)/*.o
EOF

cd src && cat > $main << EOF
/*
 * $main by $user, $currentyear 
 */

#include <stdlib.h>
#include <stdio.h>

int
main(int argv, char *argc[])
{
	return 0;
}
EOF

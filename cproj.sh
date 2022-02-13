#!/bin/bash
main="$1.c"
date=`date +"%m/%d/%Y"`
user=$(whoami)
mkdir $1 && cd $1; mkdir src include bin obj
cat > Makefile << EOF
CC=gcc
CFLAGS=-g -Wall -std=c99
LIBS=
SRCDIR=src
BINDIR=bin
OBJDIR=obj
SRCS=\$(wildcard \$(SRCDIR)/*.c)
OBJS=\$(patsubst \$(SRCDIR)/%.c, \$(OBJDIR)/%.o, \$(SRCS))
BIN=\$(BINDIR)/$1

all: \$(BIN)

release: CFLAGS=-Wall -O2 -DNDEBUG

\$(BIN): \$(OBJS)
	\$(CC) \$(CFLAGS) \$(OBJS) -o \$@ \$(LIBS) 

\$(OBJDIR)/%.o: \$(SRCDIR)/%.c
	\$(CC) \$(CFLAGS) -c \$< -o \$@

.PHONY: clean
clean:
	rm \$(BINDIR)/*.o
EOF

cd src && cat > $main << EOF
/*
 * $main
 * Original Author: $user 
 * Created: $date
 */

#include <stdlib.h>
#include <stdio.h>

#define _POSIX_C_SOURCE 200809L

int
main(int argv, char *argc[])
{
	printf("Hello World!\n");
	return 0;
}
EOF

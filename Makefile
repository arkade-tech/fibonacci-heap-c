CC = gcc
CFLAGS = -Wall -Wextra -Werror -pedantic -std=c99 -g -Iinclude -MMD -MP
SRC = $(wildcard src/*.c)
OBJ = $(SRC:src/%.c=build/%.o)
TARGET = bin/fibonacci_heap

all: $(TARGET)
$(TARGET): $(OBJ) | bin
	$(CC) $(OBJ) -o $@
build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -c $< -o $@
bin build:
	mkdir -p $@
clean:
	rm -rf bin build
run: all
	./$(TARGET)
.PHONY: all clean run

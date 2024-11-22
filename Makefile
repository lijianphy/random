CC := gcc
CFLAGS := -Wall -Wextra -std=c17 -pedantic -O2 -march=native
LDFLAGS := -lm

# List all source files
SRCS := $(wildcard *.c)
# Generate object file names by replacing .c with .o
OBJS := $(SRCS:.c=.o)
# Random number generator to use
RNG := xoshiro256plusplus

# Target executable name
TARGETS := test_random

all: $(TARGETS) $(OBJS)

%.o: %.c rng_config.h
	$(CC) $(CFLAGS) -c $< -o $@

test_random: test_random.o random.o $(RNG).o
	$(CC) $^ -o $@ $(LDFLAGS)

clean:
	rm -f $(OBJS) $(TARGETS)

.PHONY: all clean

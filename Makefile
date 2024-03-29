NAME := lib

CC := cc
CFLAGS := -std=c17 -fPIC
IFLAGS := -Isrc -Iinclude -Ilibs/colossus-core/include

SRC := $(wildcard src/*c) $(wildcard src/**/*c) $(wildcard src/**/**/*c) $(wildcard src/**/**/**/*c)
OBJ := $(SRC:%.c=%.o)

debug: CFLAGS += -ggdb -Wall -Wextra
release: CFLAGS += -O3
debug release: $(NAME)

build_libs:
	cd libs/colossus-core/ ; make release

# Compiling
%.o: %.c
	$(CC) $(CFLAGS) -c $^ -o $@ $(IFLAGS)

# Linking
$(NAME): $(OBJ) build_libs
	mkdir -p bin
	ar -rcs -o bin/lib$(NAME).a $(OBJ)

.PHONY: clean

clean:
	rm -f $(OBJ) bin/$(NAME)

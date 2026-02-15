# ===== Toolchain =====
CC      ?= cc
AR      ?= ar
RM      ?= rm -f
MKDIR_P ?= mkdir -p

# ===== Project =====
NAME    := fibonacci_heap
SRC_DIR := src
INC_DIR := include
OBJ_DIR := build
BIN_DIR := bin
TARGET  := $(BIN_DIR)/$(NAME)

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

# ===== Build Mode =====
BUILD ?= debug

WARNINGS := -Wall -Wextra -Wpedantic -Wshadow -Wformat=2 \
            -Wnull-dereference -Wstrict-prototypes \
            -Wmissing-prototypes -Wold-style-definition

CSTD := -std=c99
INCS := -I$(INC_DIR)

CFLAGS_COMMON := $(CSTD) $(INCS) $(WARNINGS) -MMD -MP
LDFLAGS_COMMON :=
LDLIBS_COMMON  :=

CFLAGS_DEBUG   := -O0 -g3
CFLAGS_RELEASE := -O3 -DNDEBUG
CFLAGS_SAN     := -O1 -g3 -fno-omit-frame-pointer -fsanitize=address,undefined
LDFLAGS_SAN    := -fsanitize=address,undefined

ifeq ($(BUILD),release)
  CFLAGS := $(CFLAGS_COMMON) $(CFLAGS_RELEASE)
  LDFLAGS := $(LDFLAGS_COMMON)
else ifeq ($(BUILD),sanitize)
  CFLAGS := $(CFLAGS_COMMON) $(CFLAGS_SAN)
  LDFLAGS := $(LDFLAGS_COMMON) $(LDFLAGS_SAN)
else
  CFLAGS := $(CFLAGS_COMMON) $(CFLAGS_DEBUG)
  LDFLAGS := $(LDFLAGS_COMMON)
endif

LDLIBS := $(LDLIBS_COMMON)

# ===== Targets =====
.PHONY: all run clean distclean lint format help

all: $(TARGET)

$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	$(MKDIR_P) $@

run: all
	./$(TARGET)

lint:
	cppcheck --enable=all --inconclusive --std=c99 \
	  -I$(INC_DIR) $(SRC_DIR)

format:
	clang-format -i $(INC_DIR)/*.h $(SRC_DIR)/*.c

clean:
	$(RM) $(OBJS) $(DEPS)

distclean:
	$(RM) -r $(OBJ_DIR) $(BIN_DIR)

help:
	@echo "Usage:"
	@echo "  make                  (debug build)"
	@echo "  make BUILD=release"
	@echo "  make BUILD=sanitize"
	@echo "  make run"
	@echo "  make clean"
	@echo "  make distclean"

-include $(DEPS)


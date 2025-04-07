CC = g++  # 改为 g++
RM = rm -rf
MKDIR = mkdir -p

TARGET = build/xplayer
SRC_DIR = src
BUILD_DIR = build
DATA_DIR=$(BUILD_DIR)/data
RESOURCE_DIR=resources
RESOURCE_FILES=$(RESOURCE_DIR)/*

SRCS = $(wildcard $(SRC_DIR)/*.cpp)  # 改为 .cpp
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

CFLAGS = -Wall -Wextra -g -Iinclude
LDFLAGS = -lavformat -lavcodec -lavutil -lswscale -lswresample -lm -lstdc++  # 添加 C++ 库

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS) | copy_resources
	@$(MKDIR) $(dir $@)
	$(CC) $^ -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(DATA_DIR):
	mkdir -p $@

copy_resources:$(RESOURCE_FILES) | $(DATA_DIR)
	cp $(RESOURCE_FILES) $(DATA_DIR)/


clean:
	$(RM) $(TARGET) $(BUILD_DIR)/*.o
	$(RM) $(DATA_DIR)


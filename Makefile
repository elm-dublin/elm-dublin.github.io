
SOURCES := $(wildcard src/*.elm)
TARGET := js/elm.js

.PHONY: all
all: $(TARGET)

$(TARGET): $(SOURCES)
	elm make src/Main.elm --warn --output $(TARGET)

clean:
	rm -f $(TARGET)

install:
	elm package install

serve: $(TARGET)
	ws --spa index.html

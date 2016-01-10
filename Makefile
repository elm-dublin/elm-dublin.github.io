
SOURCES := $(wildcard src/*.elm)
TARGET := js/elm.js
HTML := 200.html
INDEX_HTML := index.html

.PHONY: all
all: $(TARGET) $(HTML)

$(TARGET): $(SOURCES)
	elm make src/Main.elm --warn --output $(TARGET)

$(HTML): $(INDEX_HTML)
	cp $< $@

clean:
	rm -f $(TARGET) $(HTML)

install:
	elm package install

serve: $(TARGET)
	ws --spa index.html

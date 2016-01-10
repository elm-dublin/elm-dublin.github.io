
SOURCES := $(wildcard src/*.elm)
TARGET := js/elm.js
HTML := 404.html
INDEX_HTML := index.html

.PHONY: build
build: $(TARGET) $(HTML)

$(TARGET): $(SOURCES)
	elm make src/Main.elm --warn --output $@

$(HTML): $(INDEX_HTML)
	cp $< $@

clean:
	rm -rf $(TARGET) $(HTML) elm-stuff

install:
	elm package install

serve: $(TARGET)
	ws --spa index.html

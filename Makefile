
SOURCES := $(wildcard src/*.elm)
TARGET := js/elm.js
HTML := 404.html
INDEX_HTML := index.html

.PHONY: all
all: test build

.PHONY: build
build: $(TARGET) $(HTML)

$(TARGET): $(SOURCES)
	elm make src/Main.elm --warn --output $@

$(HTML): $(INDEX_HTML)
	cp $< $@

.PHONY: clean
clean:
	rm -rf $(TARGET) $(HTML) elm-stuff build

.PHONY: elm-install
elm-install:
	elm package install

.PHONY: serve
serve: $(TARGET)
	ws --spa index.html

.PHONY: test
test: $(SOURCES)
	mkdir -p build
	elm make src/ConsoleTestRunner.elm --warn --output build/raw-tests.js
	bash ./elm-stuff/packages/laszlopandy/elm-console/1.1.0/elm-io.sh build/raw-tests.js build/tests.js
	node build/tests.js

.PHONY: reactor
reactor:
	elm reactor

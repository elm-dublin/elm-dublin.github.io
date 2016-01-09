
SOURCES := $(wildcard src/*.elm)

.PHONY: all
all: elm.js

elm.js: $(SOURCES)
	elm make src/Main.elm --warn --output elm.js

clean:
	rm -f elm.js

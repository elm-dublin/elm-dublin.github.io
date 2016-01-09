
SOURCES := $(wildcard *.elm)

.PHONY: all
all: elm.js

elm.js: $(SOURCES)
	elm make Main.elm --warn --output elm.js

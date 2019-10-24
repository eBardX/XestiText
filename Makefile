.PHONY: all build clean lint reset update

all: clean update build

build:
	@ swift build -c release

clean:
	@ swift package clean

lint:
	@ swiftlint autocorrect
	@ swiftlint lint

reset:
	@ swift package reset

update:
	@ swift package update

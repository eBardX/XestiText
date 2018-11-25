.PHONY: all build clean lint reset update xcode

all: clean update build

build:
	@ swift build -c release -Xswiftc -static-stdlib

clean:
	@ swift package clean

lint:
	@ swiftlint autocorrect
	@ swiftlint lint

reset:
	@ swift package reset

update:
	@ swift package update

xcode:
	@ swift package generate-xcodeproj

.PHONY: build clean complete format lint reset test

build:
	@ swift build -c release

clean:
	@ swift package clean

complete: reset clean format lint build test

format:
	@ swiftformat .

lint:
	@ swiftlint lint

reset:
	@ swift package reset
	@ rm -f Package.resolved

test:
	@ swift test --enable-code-coverage

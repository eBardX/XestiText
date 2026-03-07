XESTI_TEXT_DOCS_DIR?=./docs
XESTI_TEXT_PRODUCT?=XestiText

HOSTING_BASE_PATH=$(XESTI_TEXT_PRODUCT)

.PHONY: all build clean lint preview publish reset test update

all: clean update build

build:
	@ swift build -c release

clean:
	@ swift package clean

lint:
	@ swiftlint lint --fix
	@ swiftlint lint

preview:
	@ open "http://localhost:8080/documentation/xestitext"
	@ swift package --disable-sandbox     \
					preview-documentation \
					--product $(XESTI_TEXT_PRODUCT)

publish:
	@ swift package --allow-writing-to-directory $(XESTI_TEXT_DOCS_DIR) \
					generate-documentation                              \
					--disable-indexing                                  \
					--hosting-base-path $(HOSTING_BASE_PATH)            \
					--output-path $(XESTI_TEXT_DOCS_DIR)                \
					--product $(XESTI_TEXT_PRODUCT)                     \
					--transform-for-static-hosting

reset:
	@ swift package reset

test:
	@ swift test --enable-code-coverage

update:
	@ swift package update

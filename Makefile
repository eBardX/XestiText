DOC_OUTPUT_PATH?=./docs
DOC_PRODUCT?=XestiText
DOC_PRODUCT_LC?=xestitext

DOC_HOSTING_BASE_PATH=$(DOC_PRODUCT)
DOC_PREVIEW_PATH="documentation/$(DOC_PRODUCT_LC)"

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
	@ open "http://localhost:8080/$(DOC_PREVIEW_PATH)"
	@ swift package --disable-sandbox     \
					preview-documentation \
					--product $(DOC_PRODUCT)

publish:
	@ swift package --allow-writing-to-directory $(DOC_OUTPUT_PATH) \
					generate-documentation                          \
					--disable-indexing                              \
					--hosting-base-path $(DOC_HOSTING_BASE_PATH)    \
					--output-path $(DOC_OUTPUT_PATH)                \
					--product $(DOC_PRODUCT)                        \
					--transform-for-static-hosting

reset:
	@ swift package reset

test:
	@ swift test --enable-code-coverage

update:
	@ swift package update

// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringCompressTests {
}

// MARK: -

extension StringCompressTests {
    @Test
    func test_compressing() {
        #expect("\tHello,   world!\r\n".compressing() == "Hello, world!")
        #expect("Thi$ i$$ a te$$$t".compressing(to: "s") { $0 == "$" } == "This is a test")
    }

    @Test
    func test_compressing_emptyString() {
        #expect("".compressing().isEmpty)
    }

    @Test
    func test_compressing_allWhitespace() {
        #expect("   \t\n\r  ".compressing().isEmpty)
    }

    @Test
    func test_compressing_noWhitespace() {
        #expect("Hello".compressing() == "Hello")
    }

    @Test
    func test_compressing_singleCharacter() {
        #expect(" ".compressing().isEmpty)
        #expect("a".compressing() == "a")
    }
}

// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringPadTests {
}

// MARK: -

extension StringPadTests {
    @Test
    func test_padding() {
        #expect("Hello, world!".padding(to: 20) == "Hello, world!       ")
        #expect("Hello, world!".padding(to: 20,
                                        alignment: .right) == "       Hello, world!")
        #expect("Hello, world!".padding(to: 20,
                                        alignment: .center) == "   Hello, world!    ")
    }

    @Test
    func test_padding_emptyString() {
        #expect("".padding(to: 5) == "     ")
        #expect("".padding(to: 5, alignment: .right) == "     ")
        #expect("".padding(to: 5, alignment: .center) == "     ")
    }

    @Test
    func test_padding_negativeWidth() {
        #expect("Hello".padding(to: -1).isEmpty)
    }

    @Test
    func test_padding_widthEqualsCount() {
        #expect("Hello".padding(to: 5) == "Hello")
    }

    @Test
    func test_padding_widthLessThanCount() {
        #expect("Hello, world!".padding(to: 5) == "Hello, world!")
    }

    @Test
    func test_padding_widthZero() {
        #expect("Hello".padding(to: 0).isEmpty)
    }
}

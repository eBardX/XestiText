// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringTruncateTests {
}

// MARK: -

extension StringTruncateTests {
    @Test
    func test_truncating() {
        #expect("Hello, world!".truncating(at: 9) == "Hello, w…")
        #expect("Hello, world!".truncating(at: 9,
                                           usingEllipses: false) == "Hello, wo")
    }

    @Test
    func test_truncating_emptyString() {
        #expect("".truncating(at: 5).isEmpty)
        #expect("".truncating(at: 0).isEmpty)
    }

    @Test
    func test_truncating_negativeWidth() {
        #expect("Hello".truncating(at: -1).isEmpty)
    }

    @Test
    func test_truncating_widthGreaterThanOrEqualToCount() {
        #expect("Hello".truncating(at: 5) == "Hello")
        #expect("Hello".truncating(at: 10) == "Hello")
    }

    @Test
    func test_truncating_widthOne_withEllipsis() {
        #expect("Hello".truncating(at: 1) == "…")
    }

    @Test
    func test_truncating_widthOne_withoutEllipsis() {
        #expect("Hello".truncating(at: 1,
                                   usingEllipses: false) == "H")
    }

    @Test
    func test_truncating_widthZero() {
        #expect("Hello".truncating(at: 0).isEmpty)
    }
}

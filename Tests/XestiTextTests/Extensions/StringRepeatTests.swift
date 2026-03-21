// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringRepeatTests {
}

// MARK: -

extension StringRepeatTests {
    @Test
    func test_repeating() {
        #expect("xyz".repeating(to: 7) == "xyzxyzxyzxyzxyzxyzxyz")
    }

    @Test
    func test_repeating_countOne() {
        #expect("xyz".repeating(to: 1) == "xyz")
    }

    @Test
    func test_repeating_countZero() {
        #expect("xyz".repeating(to: 0).isEmpty)
    }

    @Test
    func test_repeating_emptyString() {
        #expect("".repeating(to: 5).isEmpty)
    }

    @Test
    func test_repeating_negativeCount() {
        #expect("xyz".repeating(to: -1).isEmpty)
    }
}

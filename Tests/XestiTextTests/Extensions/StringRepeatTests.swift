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
}

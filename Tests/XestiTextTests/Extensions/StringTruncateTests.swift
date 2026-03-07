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
}

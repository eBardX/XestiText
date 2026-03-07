// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringFitTests {
}

// MARK: -

extension StringFitTests {
    @Test
    func test_fitting() {
        #expect("Hello, world!".fitting(to: 10,
                                        alignment: .center,
                                        usingEllipses: false) == "Hello, wor")
        #expect("Hello, world!".fitting(to: 20,
                                        alignment: .center,
                                        usingEllipses: false) == "   Hello, world!    ")
    }
}

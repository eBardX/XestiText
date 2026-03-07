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
}

// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringAlignmentTests {
}

// MARK: -

extension StringAlignmentTests {
    @Test
    func test_alignment_cases() {
        let left: String.Alignment = .left
        let center: String.Alignment = .center
        let right: String.Alignment = .right

        #expect(left == .left)
        #expect(center == .center)
        #expect(right == .right)
        #expect(left != .right)
        #expect(center != .left)
    }

    @Test
    func test_alignment_usedInPadding() {
        #expect("Hi".padding(to: 6, alignment: .left) == "Hi    ")
        #expect("Hi".padding(to: 6, alignment: .right) == "    Hi")
        #expect("Hi".padding(to: 6, alignment: .center) == "  Hi  ")
    }
}

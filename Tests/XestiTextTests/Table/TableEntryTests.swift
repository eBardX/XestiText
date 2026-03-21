// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableEntryTests {
}

extension TableEntryTests {
    @Test
    func test_textOnly() {
        let entry = Table.Entry("Hello")

        #expect(entry.alignment == nil)
        #expect(entry.text == "Hello")
    }

    @Test
    func test_withAlignment() {
        let entry = Table.Entry("Hello", .right)

        #expect(entry.alignment == .right)
        #expect(entry.text == "Hello")
    }
}

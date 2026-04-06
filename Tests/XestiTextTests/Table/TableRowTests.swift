// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableRowTests {
}

// MARK: -

extension TableRowTests {
    @Test
    func test_separator() {
        let row = Table.Row.separator

        if case .separator = row {
            // expected
        } else {
            Issue.record("Expected .separator")
        }
    }

    @Test
    func test_values() {
        let row = Table.Row.values([Table.Entry("A"),
                                    Table.Entry("B")])

        if case let .values(entries) = row {
            #expect(entries.count == 2)
        } else {
            Issue.record("Expected .values")
        }
    }
}

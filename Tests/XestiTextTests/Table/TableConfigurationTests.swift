// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableConfigurationTests {
}

extension TableConfigurationTests {
    @Test
    func test_customHeader() {
        let config = Table.Configuration(
            header: Table.HeaderOptions(span: 3, alignment: .left),
            columns: [Table.ColumnOptions(width: 5),
                      Table.ColumnOptions(width: 5),
                      Table.ColumnOptions(width: 5)])

        #expect(config.header.alignment == .left)
        #expect(config.header.span == 3)
    }

    @Test
    func test_defaultHeader() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 5)])

        #expect(config.columns.count == 1)
        #expect(config.header.alignment == .center)
        #expect(config.header.span == 1)
    }
}

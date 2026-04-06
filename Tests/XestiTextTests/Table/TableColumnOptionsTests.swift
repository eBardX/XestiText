// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableColumnOptionsTests {
}

// MARK: -

extension TableColumnOptionsTests {
    @Test
    func test_customAlignments() {
        let opts = Table.ColumnOptions(width: 10,
                                       titleAlignment: .left,
                                       valueAlignment: .right)

        #expect(opts.titleAlignment == .left)
        #expect(opts.valueAlignment == .right)
    }

    @Test
    func test_defaults() {
        let opts = Table.ColumnOptions(width: 10)

        #expect(opts.titleAlignment == .center)
        #expect(opts.valueAlignment == .left)
        #expect(opts.width == 10)
    }
}

// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableHeaderOptionsTests {
}

// MARK: -

extension TableHeaderOptionsTests {
    @Test
    func test_custom() {
        let opts = Table.HeaderOptions(span: 4, alignment: .right)

        #expect(opts.alignment == .right)
        #expect(opts.span == 4)
    }

    @Test
    func test_defaults() {
        let opts = Table.HeaderOptions()

        #expect(opts.alignment == .center)
        #expect(opts.span == 1)
    }
}

// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableMakerColumnTests {
}

// MARK: -

extension TableMakerColumnTests {
    @Test
    func test_customAlignment() {
        let col = TableMaker.Column(alignment: .right)

        #expect(col.alignment == .right)
    }

    @Test
    func test_defaultInit() {
        let col = TableMaker.Column()

        #expect(col.alignment == .left)
        #expect(col.minimumWidth >= 1)
        #expect(col.maximumWidth >= col.minimumWidth)
    }

    @Test
    func test_fixedWidth() {
        let col = TableMaker.Column(width: 10)

        #expect(col.minimumWidth == 10)
        #expect(col.maximumWidth == 10)
    }

    @Test
    func test_fixedWidth_clamped() {
        let col = TableMaker.Column(width: 0)

        #expect(col.minimumWidth >= 1)
        #expect(col.maximumWidth >= 1)
    }

    @Test
    func test_flexibleWidths() {
        let col = TableMaker.Column(minimumWidth: 5,
                                    maximumWidth: 20)

        #expect(col.minimumWidth == 5)
        #expect(col.maximumWidth == 20)
    }

    @Test
    func test_flexibleWidths_reconciled() {
        let col = TableMaker.Column(minimumWidth: 20,
                                    maximumWidth: 5)

        #expect(col.maximumWidth >= col.minimumWidth)
    }
}

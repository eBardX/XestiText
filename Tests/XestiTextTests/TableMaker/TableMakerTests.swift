// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableMakerTests {
}

// MARK: -

extension TableMakerTests {
    @Test
    func test_append_anotherMaker() {
        var maker1 = TableMaker(columns: [TableMaker.Column()])

        maker1.append(["A"])

        var maker2 = TableMaker(columns: [TableMaker.Column()])

        maker2.append(["B"])

        maker1.append(maker2)

        let table = maker1.make()
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("A"))
        #expect(rendered.contains("B"))
    }

    @Test
    func test_isEmpty_afterAppend() {
        var maker = TableMaker(columns: [TableMaker.Column()])

        maker.append(["Hello"])

        #expect(!maker.isEmpty)
    }

    @Test
    func test_isEmpty_initially() {
        let maker = TableMaker(columns: [TableMaker.Column()])

        #expect(maker.isEmpty)
    }

    @Test
    func test_make_fewerValuesThanColumns() {
        var maker = TableMaker(columns: [TableMaker.Column(),
                                         TableMaker.Column(),
                                         TableMaker.Column()])

        maker.append(["Only one"])

        let table = maker.make()
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("Only one"))
    }

    @Test
    func test_make_moreValuesThanColumns() {
        var maker = TableMaker(columns: [TableMaker.Column()])

        maker.append(["Keep", "Ignore"])

        let table = maker.make()
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("Keep"))
    }

    @Test
    func test_make_multipleRows() {
        var maker = TableMaker(columns: [TableMaker.Column(),
                                         TableMaker.Column()])

        maker.append(["A", "B"])
        maker.append(["C", "D"])

        let table = maker.make()
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("A"))
        #expect(rendered.contains("B"))
        #expect(rendered.contains("C"))
        #expect(rendered.contains("D"))
    }

    @Test
    func test_make_separatorRow() {
        var maker = TableMaker(columns: [TableMaker.Column()])

        maker.append(["A"])
        maker.append([nil])
        maker.append(["B"])

        let table = maker.make()
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("A"))
        #expect(rendered.contains("B"))
    }

    @Test
    func test_make_singleRow() {
        var maker = TableMaker(columns: [TableMaker.Column()])

        maker.append(["Hello"])

        let table = maker.make()

        #expect(table.rows.count >= 1)
    }

    @Test
    func test_make_withWidthLimits() {
        var maker = TableMaker(columns: [TableMaker.Column()],
                               minimumWidth: 20,
                               maximumWidth: 40)

        maker.append(["Test"])

        let table = maker.make()

        #expect(table.rows.count >= 1)
    }
}

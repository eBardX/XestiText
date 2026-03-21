// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableTests {
}

// MARK: -

extension TableTests {
    @Test
    func test_init() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 10),
                                                   Table.ColumnOptions(width: 15)])
        let table = Table(configuration: config,
                          rows: [.values([Table.Entry("A"),
                                          Table.Entry("B")])])

        #expect(table.columnTitles == nil)
        #expect(table.configuration.columns.count == 2)
        #expect(table.headerTitle == nil)
        #expect(table.rows.count == 1)
    }

    @Test
    func test_render_differentBoxStyles() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 5)])
        let table = Table(configuration: config,
                          rows: [.values([Table.Entry("Hi")])])

        let light = table.render(using: .light)

        #expect(light.contains("─"))
        #expect(light.contains("│"))

        let heavy = table.render(using: .heavy)

        #expect(heavy.contains("━"))
        #expect(heavy.contains("┃"))

        let double = table.render(using: .double)

        #expect(double.contains("═"))
        #expect(double.contains("║"))
    }

    @Test
    func test_render_headerWithPartialSpan() {
        let config = Table.Configuration(
            header: Table.HeaderOptions(span: 1),
            columns: [Table.ColumnOptions(width: 8),
                      Table.ColumnOptions(width: 8)])
        let table = Table(configuration: config,
                          headerTitle: Table.Entry("Title"),
                          rows: [.values([Table.Entry("A"),
                                          Table.Entry("B")])])
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("Title"))
    }

    @Test
    func test_render_multipleColumns() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 5),
                                                   Table.ColumnOptions(width: 8)])
        let table = Table(configuration: config,
                          rows: [.values([Table.Entry("Hi"),
                                          Table.Entry("World")])])
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("Hi"))
        #expect(rendered.contains("World"))
    }

    @Test
    func test_render_plain() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 5)])
        let table = Table(configuration: config,
                          rows: [.values([Table.Entry("Hello")])])
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("+"))
        #expect(rendered.contains("Hello"))
    }

    @Test
    func test_render_withHeaderAndColumnTitles() {
        let config = Table.Configuration(
            header: Table.HeaderOptions(span: 2, alignment: .center),
            columns: [Table.ColumnOptions(width: 8),
                      Table.ColumnOptions(width: 8)])
        let table = Table(configuration: config,
                          headerTitle: Table.Entry("Header"),
                          columnTitles: [Table.Entry("Col A"),
                                         Table.Entry("Col B")],
                          rows: [.values([Table.Entry("1"),
                                          Table.Entry("2")])])
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("Header"))
        #expect(rendered.contains("Col A"))
        #expect(rendered.contains("Col B"))
        #expect(rendered.contains("1"))
        #expect(rendered.contains("2"))
    }

    @Test
    func test_render_withSeparator() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 5)])
        let table = Table(configuration: config,
                          rows: [.values([Table.Entry("A")]),
                                 .separator,
                                 .values([Table.Entry("B")])])
        let rendered = table.render(using: .plain)

        #expect(rendered.contains("A"))
        #expect(rendered.contains("B"))
    }

    @Test
    func test_withColumnTitles() {
        let config = Table.Configuration(columns: [Table.ColumnOptions(width: 10),
                                                   Table.ColumnOptions(width: 10)])
        let titles = [Table.Entry("Col1"), Table.Entry("Col2")]
        let table = Table(configuration: config,
                          columnTitles: titles,
                          rows: [.values([Table.Entry("A"), Table.Entry("B")])])

        #expect(table.columnTitles?.count == 2)
    }

    @Test
    func test_withHeaderTitle() {
        let config = Table.Configuration(
            header: Table.HeaderOptions(span: 2),
            columns: [Table.ColumnOptions(width: 10),
                      Table.ColumnOptions(width: 10)])
        let table = Table(configuration: config,
                          headerTitle: Table.Entry("Title"),
                          rows: [.values([Table.Entry("A"),
                                          Table.Entry("B")])])

        #expect(table.headerTitle != nil)
        #expect(table.headerTitle?.text == "Title")
    }
}

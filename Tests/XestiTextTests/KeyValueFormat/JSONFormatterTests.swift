// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiText

struct JSONFormatterTests {
}

// MARK: -

extension JSONFormatterTests {
    @Test
    func test_addIfPresent_withNil() {
        var formatter = JSONFormatter()

        formatter.addIfPresent("key", nil)

        let result = formatter.format()

        #expect(result == "{}")
    }

    @Test
    func test_addIfPresent_withValue() {
        var formatter = JSONFormatter()

        formatter.addIfPresent("key", "value" as (any Sendable)?)

        let result = formatter.format()

        #expect(result.contains("\"key\""))
        #expect(result.contains("\"value\""))
    }

    @Test
    func test_format_arrayOfFormattables() {
        var formatter = JSONFormatter()

        let items: [any KeyValueFormattable & Sendable] = [TestFormattable(name: "a", value: 1),
                                                           TestFormattable(name: "b", value: 2)]

        formatter.add("items", items)

        let result = formatter.format()

        #expect(result.contains("\"items\""))
    }

    @Test
    func test_format_emptyFormatter() {
        let formatter = JSONFormatter()
        let result = formatter.format()

        #expect(result == "{}")
    }

    @Test
    func test_format_multiplePairs() {
        var formatter = JSONFormatter()

        formatter.add("name", "Alice")
        formatter.add("age", 30)

        let result = formatter.format()

        #expect(result.contains("\"name\""))
        #expect(result.contains("\"age\""))
        #expect(result.contains("30"))
    }

    @Test
    func test_format_nestedFormattable() {
        var formatter = JSONFormatter()

        let inner = TestFormattable(name: "inner", value: 42)

        formatter.add("nested", inner)

        let result = formatter.format()

        #expect(result.contains("\"nested\""))
        #expect(result.contains("\"name\""))
        #expect(result.contains("\"inner\""))
    }

    @Test
    func test_format_nilValue() {
        var formatter = JSONFormatter()

        formatter.add("key", NSNull())

        let result = formatter.format()

        #expect(result.contains("null"))
    }

    @Test
    func test_format_nonJSONSerializableValue() {
        var formatter = JSONFormatter()

        guard let url = URL(string: "https://example.com")
        else { return }

        formatter.add("key", url)

        let result = formatter.format()

        #expect(result.contains("\"key\""))
        #expect(result.contains("example.com"))
    }

    @Test
    func test_format_singlePair() {
        var formatter = JSONFormatter()

        formatter.add("name", "Alice")

        let result = formatter.format()

        #expect(result.contains("\"name\""))
        #expect(result.contains("\"Alice\""))
    }

    @Test
    func test_addSeparator_noOp() {
        var formatter = JSONFormatter()

        formatter.add("a", 1)
        formatter.addSeparator()
        formatter.add("b", 2)

        let result = formatter.format()

        #expect(result.contains("\"a\""))
        #expect(result.contains("\"b\""))
    }
}

// MARK: - Helpers

private struct TestFormattable: KeyValueFormattable, Sendable {
    let name: String
    let value: Int

    func format(with formatter: inout some KeyValueFormatter) {
        formatter.add("name", name)
        formatter.add("value", value)
    }
}

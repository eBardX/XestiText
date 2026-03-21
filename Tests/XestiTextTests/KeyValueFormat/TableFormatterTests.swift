// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiText

struct TableFormatterTests {
}

// MARK: -

extension TableFormatterTests {
    @Test
    func test_addIfPresent_withValue() {
        var formatter = TableFormatter()

        formatter.addIfPresent("Key", "Value" as (any Sendable)?)

        let result = formatter.format()

        #expect(result.contains("Key"))
        #expect(result.contains("Value"))
    }

    @Test
    func test_format_arrayOfValues() {
        var formatter = TableFormatter()

        let values: [any Sendable] = ["a", "b", "c"]

        formatter.add("Items", values)

        let result = formatter.format()

        #expect(result.contains("Items"))
        #expect(result.contains("a"))
    }

    @Test
    func test_format_multiplePairs() {
        var formatter = TableFormatter()

        formatter.add("Name", "Alice")
        formatter.add("Age", "30")

        let result = formatter.format()

        #expect(result.contains("Name"))
        #expect(result.contains("Alice"))
        #expect(result.contains("Age"))
        #expect(result.contains("30"))
    }

    @Test
    func test_format_nilValue() {
        var formatter = TableFormatter()

        formatter.add("Key", NSNull())

        let result = formatter.format()

        #expect(result.contains("Key"))
    }

    @Test
    func test_format_singlePair() {
        var formatter = TableFormatter()

        formatter.add("Name", "Alice")

        let result = formatter.format()

        #expect(result.contains("Name"))
        #expect(result.contains("Alice"))
    }

    @Test
    func test_format_withBox() {
        var formatter = TableFormatter(.light)

        formatter.add("Key", "Value")

        let result = formatter.format()

        #expect(result.contains("─"))
        #expect(result.contains("│"))
    }

    @Test
    func test_format_withSeparator() {
        var formatter = TableFormatter()

        formatter.add("A", "1")
        formatter.addSeparator()
        formatter.add("B", "2")

        let result = formatter.format()

        #expect(result.contains("A"))
        #expect(result.contains("B"))
    }
}

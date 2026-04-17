// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText
import XestiTools

struct FormatterTests {
}

// MARK: -

extension FormatterTests {
    @Test
    func test_hangIndent_longPrefix() {
        let result = Formatter.hangIndent(prefix: "LONGPREFIX",
                                          text: "value",
                                          hangPadLeft: 0,
                                          hangWidth: 4,
                                          hangPadRight: 0,
                                          totalWidth: 40)

        #expect(result.contains("LONGPREFIX"))
        #expect(result.contains("\n"))
        #expect(result.contains("value"))
    }

    @Test
    func test_hangIndent_nonPositiveWrapWidth() {
        let result = Formatter.hangIndent(prefix: "A",
                                          text: "B",
                                          hangPadLeft: 0,
                                          hangWidth: 5,
                                          hangPadRight: 0,
                                          totalWidth: 3)

        #expect(result.contains("A"))
        #expect(result.contains("B"))
    }

    @Test
    func test_hangIndent_shortText() {
        let result = Formatter.hangIndent(prefix: "AB",
                                          text: "cd",
                                          hangPadLeft: 0,
                                          hangWidth: 4,
                                          hangPadRight: 1,
                                          totalWidth: 40)

        #expect(result.hasPrefix("AB"))
        #expect(result.contains("cd"))
    }

    @Test
    func test_hangIndent_simple() {
        let result = Formatter.hangIndent(prefix: "KEY",
                                          text: "value",
                                          totalWidth: 40)

        #expect(result.contains("KEY"))
        #expect(result.contains("value"))
    }

    @Test
    func test_hangIndent_withPadding() {
        let result = Formatter.hangIndent(prefix: "A",
                                          text: "B",
                                          hangPadLeft: 2,
                                          hangWidth: 3,
                                          hangPadRight: 1,
                                          totalWidth: 40)

        #expect(result.hasPrefix("  A"))
    }

    @Test
    func test_hangIndent_wrapsLongText() {
        let longText = "This is a longer piece of text that should wrap around at the given width"
        let result = Formatter.hangIndent(prefix: "P:",
                                          text: longText,
                                          totalWidth: 20)

        #expect(result.contains("\n"))
    }

    @Test
    func test_formattedDescription_customPrefixes() {
        let error = TestExtendedError(hints: ["hint"],
                                      hintsPrefix: "  * ",
                                      message: "oops",
                                      messagePrefix: "FAIL: ")

        let result = Formatter.formattedDescription(for: error)

        #expect(result.contains("oops"))
        #expect(result.contains("  * hint"))
    }

    @Test
    func test_formattedDescription_messageOnly() {
        let error = TestExtendedError(message: "something went wrong")

        let result = Formatter.formattedDescription(for: error)

        #expect(result == "something went wrong")
    }

    @Test
    func test_formattedDescription_messageWithHints() {
        let error = TestExtendedError(hints: ["check your input",
                                              "try again later"],
                                      message: "something went wrong")

        let result = Formatter.formattedDescription(for: error)

        #expect(result.contains("something went wrong"))
        #expect(result.contains("     - check your input"))
        #expect(result.contains("     - try again later"))
    }

    @Test
    func test_minimumTerminalWidth() {
        #expect(Formatter.minimumTerminalWidth == 80)
    }

    @Test
    func test_terminalWidth_atLeastMinimum() {
        #expect(Formatter.terminalWidth() >= Formatter.minimumTerminalWidth)
    }
}

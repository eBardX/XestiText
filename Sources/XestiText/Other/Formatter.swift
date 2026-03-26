// © 2018–2026 John Gary Pusey (see LICENSE.md)

private import CoreFoundation

/// A namespace for type properties and methods related to formatting text for
/// display on terminal type devices.
public enum Formatter {

    // MARK: Public Type Properties

    /// The minimum width of a terminal type device for formatting purposes.
    public static let minimumTerminalWidth = 80

    // MARK: Public Type Methods

    /// Formats the provided prefix and text into a string using hanging
    /// indentation.
    ///
    /// The prefix and text are formatted to fit within the specified total
    /// width.
    ///
    /// This method is equivalent to calling:
    ///
    /// ```swift
    /// hangIndent(prefix: prefix,
    ///            text: text,
    ///            hangPadLeft: 0,
    ///            hangWidth: prefix.count,
    ///            hangPadRight: 0,
    ///            totalWidth: totalWidth)
    /// ```
    ///
    /// - Parameter prefix:     The string to format first. It comes before
    ///                         `text` in the result string.
    /// - Parameter text:       The string to format second. It comes after
    ///                         `prefix` in the result string.
    /// - Parameter totalWidth: The total width into which `prefix` and
    ///                         `text` are wrapped.
    ///
    /// - Returns:  The formatted prefix and text.
    public static func hangIndent(prefix: String,
                                  text: String,
                                  totalWidth: Int) -> String {
        hangIndent(prefix: prefix,
                   text: text,
                   hangPadLeft: 0,
                   hangWidth: prefix.count,
                   hangPadRight: 0,
                   totalWidth: totalWidth)
    }

    /// Formats the provided prefix and text into a string using hanging
    /// indentation.
    ///
    /// The prefix and text are wrapped to fit within the specified total width
    /// using hanging indentation in accordance with the given measurements.
    ///
    /// - Parameter prefix:         The string to format first. It comes before
    ///                             `text` in the result string.
    /// - Parameter text:           The string to format second. It comes after
    ///                             `prefix` in the result string.
    /// - Parameter hangPadLeft:    The number of space characters with which to
    ///                             left pad `prefix`, if its length is less
    ///                             than `hangWidth`.
    /// - Parameter hangWidth:      The width of the hanging indentation.
    /// - Parameter hangPadRight:   The number of space characters with which to
    ///                             right pad `prefix`, if its length is less
    ///                             than `hangWidth`.
    /// - Parameter totalWidth:     The total width into which `prefix` and
    ///                             `text` are wrapped.
    ///
    /// - Returns:  The formatted prefix and text.
    public static func hangIndent(prefix: String,
                                  text: String,
                                  hangPadLeft: Int,
                                  hangWidth: Int,
                                  hangPadRight: Int,
                                  totalWidth: Int) -> String {
        var result = ""

        let columnWidth = hangPadLeft + hangWidth + hangPadRight

        if hangPadLeft > 0 {
            result += " ".repeating(to: hangPadLeft)
        }

        result += prefix

        if prefix.count > hangWidth {
            result += "\n"
            result += " ".repeating(to: hangPadLeft + hangWidth)
        } else {
            result += " ".repeating(to: hangWidth - prefix.count)
        }

        if hangPadRight > 0 {
            result += " ".repeating(to: hangPadRight)
        }

        let wrapWidth = totalWidth - columnWidth

        guard wrapWidth > 0
        else { return result + text }

        let lines = text.wrapping(at: wrapWidth)

        guard lines.count > 1
        else { return result + (lines.first ?? "") }

        let separator = "\n" + " ".repeating(to: columnWidth)

        return result + lines.joined(separator: separator)
    }

    /// Determines the width of the terminal type device associated with
    /// standard output.
    ///
    /// If standard output is not associated with a valid terminal type device,
    /// this method returns ``minimumTerminalWidth``.
    ///
    /// - Returns:  The width of the terminal type device.
    public static func terminalWidth() -> Int {
        guard Terminal.isTerminal,
              let size = Terminal.size()
        else { return minimumTerminalWidth }

        return max(Int(size.width),
                   minimumTerminalWidth)
    }
}

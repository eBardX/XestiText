//
//  Format.swift
//  XestiText
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

public enum Format {

    // MARK: Public Type Properties

    public static let minimumTerminalWidth = 80

    // MARK: Public Type Methods

    public static func hangIndent(prefix: String,
                                  text: String,
                                  totalWidth: Int) -> String {
        return hangIndent(prefix: prefix,
                          text: text,
                          hangPadLeft: 0,
                          hangWidth: prefix.displayWidth,
                          hangPadRight: 0,
                          totalWidth: totalWidth)
    }

    public static func hangIndent(prefix: String,
                                  text: String,
                                  hangPadLeft: Int,
                                  hangWidth: Int,
                                  hangPadRight: Int,
                                  totalWidth: Int) -> String {
        var result = ""

        let columnWidth = hangPadLeft + hangWidth + hangPadRight

        if hangPadLeft > 0 {
            result += " ".repeat(hangPadLeft)
        }

        result += prefix

        if prefix.displayWidth > hangWidth {
            result += "\n"
            result += " ".repeat(hangPadLeft + hangWidth)
        } else {
            result += " ".repeat(hangWidth - prefix.displayWidth)
        }

        if hangPadRight > 0 {
            result += " ".repeat(hangPadRight)
        }

        let lines = text.wrap(totalWidth - columnWidth)

        guard
            lines.count > 1
            else { return result + (lines.first ?? "") }

        let separator = "\n" + " ".repeat(columnWidth)

        return result + lines.joined(separator: separator)
    }

    public static func terminalWidth() -> Int {
        guard
            Terminal.isTerminal,
            let size = Terminal.size()
            else { return minimumTerminalWidth }

        return max(Int(size.width),
                   minimumTerminalWidth)
    }
}

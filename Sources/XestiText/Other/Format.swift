// © 2018–2024 John Gary Pusey (see LICENSE.md)

public enum Format {

    // MARK: Public Type Properties

    public static let minimumTerminalWidth = 80

    // MARK: Public Type Methods

    public static func hangIndent(prefix: String,
                                  text: String,
                                  totalWidth: Int) -> String {
        hangIndent(prefix: prefix,
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
            result += " ".repeating(to: hangPadLeft)
        }

        result += prefix

        if prefix.displayWidth > hangWidth {
            result += "\n"
            result += " ".repeating(to: hangPadLeft + hangWidth)
        } else {
            result += " ".repeating(to: hangWidth - prefix.displayWidth)
        }

        if hangPadRight > 0 {
            result += " ".repeating(to: hangPadRight)
        }

        let lines = text.wrapping(at: totalWidth - columnWidth)

        guard lines.count > 1
        else { return result + (lines.first ?? "") }

        let separator = "\n" + " ".repeating(to: columnWidth)

        return result + lines.joined(separator: separator)
    }

    public static func terminalWidth() -> Int {
        guard Terminal.isTerminal,
              let size = Terminal.size()
        else { return minimumTerminalWidth }

        return max(Int(size.width),
                   minimumTerminalWidth)
    }
}

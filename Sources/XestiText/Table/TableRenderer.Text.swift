// © 2018–2024 John Gary Pusey (see LICENSE.md)

extension TableRenderer {

    // MARK: Internal Nested Types

    internal class Text {

        // MARK: Internal Initializers

        internal init(_ rawText: String? = nil,
                      _ alignment: String.Alignment = .center) {
            self.alignment = alignment
            self.lines = Self._splitIntoLines(rawText)
        }

        // MARK: Private Instance Properties

        private let alignment: String.Alignment
        private let lines: [String]
    }
}

// MARK: -

extension TableRenderer.Text {

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        lines.isEmpty
    }

    internal var maximumDisplayWidth: Int {
        lines.reduce(0) { max($0, $1.displayWidth) }
    }

    // MARK: Internal Instance Methods

    internal func format(for width: Int) -> [String] {
        lines.flatMap { $0.wrapping(at: width, splitWords: true) }.map { _pad($0, width) }
    }

    // MARK: Private Type Methods

    private static func _splitIntoLines(_ rawText: String?) -> [String] {
        guard let text = rawText
        else { return [] }

        return text
            .split(omittingEmptySubsequences: false) { $0.isNewline }
            .map { String($0).compressing() }
    }

    // MARK: Private Instance Methods

    private func _pad(_ text: String,
                      _ width: Int) -> String {
        let padWidth = width - text.displayWidth

        guard padWidth > 0
        else { return text }

        switch alignment {
        case .center:
            let padWidthL = padWidth / 2
            let padWidthR = padWidth - padWidthL

            return " ".repeating(to: padWidthL) + text + " ".repeating(to: padWidthR)

        case .left:
            return text + " ".repeating(to: padWidth)

        case .right:
            return " ".repeating(to: padWidth) + text
        }
    }
}

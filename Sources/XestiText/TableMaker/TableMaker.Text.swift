// © 2025 John Gary Pusey (see LICENSE.md)

extension TableMaker {

    // MARK: Internal Nested Types

    internal struct Text {

        // MARK: Internal Initializers

        internal init(_ text: String? = nil,
                      _ alignment: String.Alignment = .center) {
            self.alignment = alignment
            self.lines = Self._splitIntoLines(text)
        }

        // MARK: Private Instance Properties

        private let alignment: String.Alignment
        private let lines: [String]
    }
}

// MARK: -

extension TableMaker.Text {

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        lines.isEmpty
    }

    internal var maximumLineWidth: Int {
        lines.reduce(0) { max($0, $1.count) }
    }

    // MARK: Internal Instance Methods

    internal func format(for width: Int) -> [String] {
        lines.flatMap { $0.wrapping(at: width,
                                    splitWords: true)
        }.map { $0.padding(to: width,
                           alignment: alignment)
        }
    }

    // MARK: Private Type Methods

    private static func _splitIntoLines(_ text: String?) -> [String] {
        guard let text
        else { return [] }

        return text
            .split(omittingEmptySubsequences: false) { $0.isNewline }
            .map { String($0).compressing() }
    }
}

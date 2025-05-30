// © 2025 John Gary Pusey (see LICENSE.md)

extension TableFormatter {

    // MARK: Internal Nested Types

    internal struct Pair: Sendable {

        // MARK: Internal Initializers

        internal init(_ text: String? = nil,
                      _ alignment: String.Alignment = .center) {
            self.alignment = alignment
            self.lines = Self._splitIntoLines(text)
        }

        internal init(_ key: Text,
                      _ value: Text) {
            self.key = key
            self.value = value
        }

        // MARK: Internal Instance Properties

        internal let key: Text
        internal let value: Text
    }
}

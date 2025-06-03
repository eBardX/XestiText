// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public struct HeaderOptions {

        // MARK: Public Initializers

        public init(span: Int = 1,
                    alignment: String.Alignment = .center) {
            precondition(span > 0)

            self.alignment = alignment
            self.span = span
        }

        // MARK: Public Instance Properties

        public let alignment: String.Alignment
        public let span: Int
    }
}

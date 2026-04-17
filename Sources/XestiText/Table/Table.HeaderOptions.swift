// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    /// Span and alignment options for a table header.
    public struct HeaderOptions {

        // MARK: Public Initializers

        /// Creates new options for a table header.
        ///
        /// - Parameter span:       The span in columns of the table header.
        ///                         Defaults to `1`.
        /// - Parameter alignment:  The alignment of the table header. Defaults
        ///                         to `.center`.
        ///
        /// - Precondition: `span` must be greater than zero.
        public init(span: Int = 1,
                    alignment: String.Alignment = .center) {
            precondition(span > 0)

            self.alignment = alignment
            self.span = span
        }

        // MARK: Public Instance Properties

        /// The alignment of the table header.
        public let alignment: String.Alignment

        /// The span in columns of the table header.
        public let span: Int
    }
}

// MARK: - Sendable

extension Table.HeaderOptions: Sendable {
}

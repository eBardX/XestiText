// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    /// A table entry.
    ///
    /// In a table, an ``Entry`` instance supplies the text, and possibly
    /// overrides its alignment, for a cell, a column title, or the header
    /// title.
    public struct Entry {

        // MARK: Public Initializers

        /// Creates a new table entry with the provided text and optional
        /// alignment.
        ///
        /// - Parameter text:       The text of the table entry.
        /// - Parameter alignment:  The optional alignment of the table entry.
        ///                         This value, if not `nil`, overrides any
        ///                         alignment specified in the table
        ///                         configuration. Defaults to `nil`.
        public init(_ text: String,
                    _ alignment: String.Alignment? = nil) {
            self.alignment = alignment
            self.text = text
        }

        // MARK: Public Instance Properties

        /// The optional alignment of the text of the table entry.
        public let alignment: String.Alignment?

        /// The text of the table entry.
        public let text: String
    }
}

// MARK: - Sendable

extension Table.Entry: Sendable {
}

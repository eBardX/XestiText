// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    /// Width and alignment options for a table column.
    public struct ColumnOptions {

        // MARK: Public Initializers

        /// Creates new options for a table column.
        ///
        /// - Parameter width:          The width of the table column.
        /// - Parameter titleAlignment: The alignment of the title of the table
        ///                             column. Defaults to `.center`.
        /// - Parameter valueAlignment: The alignment of all cell values of the
        ///                             table column. Defaults to `.left`.
        public init(width: Int,
                    titleAlignment: String.Alignment = .center,
                    valueAlignment: String.Alignment = .left) {
            precondition(width > 0)

            self.titleAlignment = titleAlignment
            self.valueAlignment = valueAlignment
            self.width = width
        }

        // MARK: Public Instance Properties

        /// The alignment of the title of the table column.
        public let titleAlignment: String.Alignment

        /// The alignment of all cell values of the table column.
        public let valueAlignment: String.Alignment

        /// The width of the table column.
        public let width: Int
    }
}

// MARK: - Sendable

extension Table.ColumnOptions: Sendable {
}

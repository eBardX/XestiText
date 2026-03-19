// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension TableMaker {

    // MARK: Public Nested Types

    /// The description of a column in a table to be constructed by a
    /// ``TableMaker`` instance.
    public struct Column {

        // MARK: Public Initializers

        /// Creates a new table column description.
        ///
        /// - Parameter minimumWidth:   The minimum width of the column in the
        ///                             table to be constructed. If this value
        ///                             is `nil`, ``Limits/minimumColumnWidth``
        ///                             is used. Defaults to `nil`.
        /// - Parameter maximumWidth:   The maximum width of the column in the
        ///                             table to be constructed. If this value
        ///                             is `nil`, ``Limits/maximumColumnWidth``
        ///                             is used. Defaults to `nil`.
        /// - Parameter alignment:      The alignment of all cells of the column
        ///                             in the table to be constructed. Defaults
        ///                             to `.left`.
        public init(minimumWidth: Int? = nil,
                    maximumWidth: Int? = nil,
                    alignment: String.Alignment = .left) {
            let tmpMaximumWidth = min(maximumWidth ?? Limits.maximumColumnWidth,
                                      Limits.maximumColumnWidth)
            let tmpMinimumWidth = max(minimumWidth ?? Limits.minimumColumnWidth,
                                      Limits.minimumColumnWidth)

            self.alignment = alignment
            self.maximumWidth = max(tmpMaximumWidth,
                                    tmpMinimumWidth)
            self.minimumWidth = min(tmpMinimumWidth,
                                    tmpMaximumWidth)
        }

        /// Creates a new table column description with a fixed width.
        ///
        /// - Parameter width:      The fixed width of the column in the table
        ///                         to be constructed. This value is clamped
        ///                         between ``Limits/minimumColumnWidth`` and
        ///                         ``Limits/maximumColumnWidth``.
        /// - Parameter alignment:  The alignment of all cells of the column in
        ///                         the table to be constructed. Defaults to
        ///                         `.left`.
        public init(width: Int,
                    alignment: String.Alignment = .left) {
            let tmpWidth = max(Limits.minimumColumnWidth,
                               min(width, Limits.maximumColumnWidth))

            self.alignment = alignment
            self.maximumWidth = tmpWidth
            self.minimumWidth = tmpWidth
        }

        // MARK: Public Instance Properties

        /// The alignment of all cells of the column in the table to be
        /// constructed.
        public let alignment: String.Alignment

        /// The maximum width of the column in the table to be constructed.
        public let maximumWidth: Int

        /// The minimum width of the column in the table to be constructed.
        public let minimumWidth: Int
    }
}

// MARK: - Sendable

extension TableMaker.Column: Sendable {
}

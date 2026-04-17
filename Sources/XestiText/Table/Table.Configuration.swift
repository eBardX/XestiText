// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    /// A configuration supplying header and column options for a table.
    public struct Configuration {

        // MARK: Public Initializers

        /// Creates a new table configuration.
        ///
        /// - Parameter header:     A ``HeaderOptions`` instance. Defaults to
        ///                         the default settings for header options.
        /// - Parameter columns:    An array of ``ColumnOptions`` instances. You
        ///                         must provide options for at least one
        ///                         column.
        ///
        /// - Precondition: `columns` must not be empty.
        public init(header: HeaderOptions = HeaderOptions(),
                    columns: [ColumnOptions]) {
            precondition(!columns.isEmpty)

            self.columns = columns
            self.header = header
        }

        // MARK: Public Instance Properties

        /// The array of ``ColumnOptions`` instances.
        public let columns: [ColumnOptions]

        /// The ``HeaderOptions`` instance.
        public let header: HeaderOptions
    }
}

// MARK: - Sendable

extension Table.Configuration: Sendable {
}

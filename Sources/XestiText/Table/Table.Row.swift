// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    /// A container for either a row of table cell values or a table row
    /// separator.
    public enum Row {
        /// A table row separator.
        case separator

        /// A row of table cell values. In this case, the associated value is an
        /// array of ``Entry`` instances.
        case values([Entry])
    }
}

// MARK: - Sendable

extension Table.Row: Sendable {
}

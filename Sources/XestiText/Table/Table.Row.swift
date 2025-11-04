// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public enum Row {
        case separator
        case values([Entry])
    }
}

// MARK: - Sendable

extension Table.Row: Sendable {
}

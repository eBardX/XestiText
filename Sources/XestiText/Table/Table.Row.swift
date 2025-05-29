// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public enum Row: Sendable {
        case separator
        case values([Entry])
    }
}

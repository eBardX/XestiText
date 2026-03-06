// © 2024–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Nested Types

    public enum Alignment {
        case left
        case center
        case right
    }
}

// MARK: - Sendable

extension String.Alignment: Sendable {
}

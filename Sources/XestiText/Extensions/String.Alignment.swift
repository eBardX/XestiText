// © 2024–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Nested Types

    /// An alignment position for text along the horizontal axis.
    public enum Alignment {
        /// Left alignment.
        case left

        /// Center alignment.
        case center

        /// Right alignment.
        case right
    }
}

// MARK: - Sendable

extension String.Alignment: Sendable {
}

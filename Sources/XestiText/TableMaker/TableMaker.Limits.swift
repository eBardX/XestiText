// © 2025–2026 John Gary Pusey (see LICENSE.md)

extension TableMaker {

    // MARK: Public Nested Types

    /// Limits for the construction of tables by a ``TableMaker`` instance.
    public enum Limits {

        // MARK: Public Type Properties

        /// The maximum width of a column in a table to be constructed.
        public static let maximumColumnWidth = max(terminalWidth, 80)

        /// The maximum width of a table to be constructed.
        public static let maximumTableWidth = max(terminalWidth, 80)

        /// The minimum width of a column in a table to be constructed.
        public static let minimumColumnWidth = 1

        /// The minimum width of a table to be constructed.
        public static let minimumTableWidth = 1

        // MARK: Private Type Properties

        private static let terminalWidth = Formatter.terminalWidth()
    }
}

// MARK: - Sendable

extension TableMaker.Limits: Sendable {
}

// © 2025 John Gary Pusey (see LICENSE.md)

extension TableMaker {

    // MARK: Public Nested Types

    public enum Limits {

        // MARK: Public Type Properties

        public static let maximumColumnWidth = max(terminalWidth, 80)
        public static let maximumTableWidth  = max(terminalWidth, 80)
        public static let minimumColumnWidth = 1
        public static let minimumTableWidth  = 1

        // MARK: Private Type Properties

        private static let terminalWidth = Formatter.terminalWidth()
    }
}

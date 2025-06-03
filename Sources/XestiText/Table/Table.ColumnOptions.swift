// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public struct ColumnOptions {

        // MARK: Public Initializers

        public init(width: Int,
                    titleAlignment: String.Alignment = .center,
                    valueAlignment: String.Alignment = .left) {
            precondition(width > 0)

            self.titleAlignment = titleAlignment
            self.valueAlignment = valueAlignment
            self.width = width
        }

        // MARK: Public Instance Properties

        public let titleAlignment: String.Alignment
        public let valueAlignment: String.Alignment
        public let width: Int
    }
}

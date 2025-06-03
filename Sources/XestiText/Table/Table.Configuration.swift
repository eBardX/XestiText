// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public struct Configuration {

        // MARK: Public Initializers

        public init(header: HeaderOptions = .init(),
                    columns: [ColumnOptions]) {
            precondition(!columns.isEmpty)

            self.columns = columns
            self.header = header
        }

        // MARK: Public Instance Properties

        public let columns: [ColumnOptions]
        public let header: HeaderOptions
    }
}

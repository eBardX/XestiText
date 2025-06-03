// © 2025 John Gary Pusey (see LICENSE.md)

extension TableMaker {

    // MARK: Public Nested Types

    public struct Column {

        // MARK: Public Initializers

        public init(minimumWidth: Int? = nil,
                    maximumWidth: Int? = nil,
                    alignment: String.Alignment = .left) {
            self.alignment = alignment
            self.maximumWidth = min(maximumWidth ?? Limits.maximumColumnWidth,
                                    Limits.maximumColumnWidth)
            self.minimumWidth = max(minimumWidth ?? Limits.minimumColumnWidth,
                                    Limits.minimumColumnWidth)
        }

        public init(width: Int,
                    alignment: String.Alignment = .left) {
            self.alignment = alignment
            self.maximumWidth = min(width, Limits.maximumColumnWidth)
            self.minimumWidth = max(width, Limits.minimumColumnWidth)
        }

        // MARK: Public Instance Properties

        public let alignment: String.Alignment
        public let maximumWidth: Int
        public let minimumWidth: Int
    }
}

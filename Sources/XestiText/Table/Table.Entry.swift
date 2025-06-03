// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public struct Entry {

        // MARK: Public Initializers

        public init(_ text: String,
                    _ alignment: String.Alignment? = nil) {
            self.alignment = alignment
            self.text = text
        }

        // MARK: Public Instance Properties

        public let alignment: String.Alignment?
        public let text: String
    }
}

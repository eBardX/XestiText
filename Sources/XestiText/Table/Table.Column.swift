// © 2018–2024 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public struct Column {

        // MARK: Public Initializers

        public init(header: String? = nil,
                    values: [String] = [],
                    alignment: String.Alignment? = nil,
                    minimumWidth: Int? = nil,
                    maximumWidth: Int? = nil) {
            self.alignment = alignment
            self.header = header
            self.maximumWidth = maximumWidth
            self.minimumWidth = minimumWidth
            self.values = values
        }

        // MARK: Public Instance Properties

        public var alignment: String.Alignment?
        public var header: String?
        public var maximumWidth: Int?
        public var minimumWidth: Int?
        public var values: [String]
    }
}

extension Table.Column {

    // MARK: Public Instance Properties

    public var isEmpty: Bool {
        values.isEmpty
    }

    // MARK: Public Instance Methods

    public mutating func append(_ value: String) {
        values.append(value)
    }

    public mutating func extend(to count: Int) {
        let padCount = count - values.count

        guard padCount > 0
        else { return }

        values += Array(repeating: "",
                        count: padCount)
    }
}

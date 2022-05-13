// © 2018–2022 J. G. Pusey (see LICENSE.md)

public extension Table {

    // MARK: Public Nested Types

    struct Column {

        // MARK: Public Initializers

        public init(header: String? = nil,
                    values: [String] = [],
                    alignment: Alignment? = nil,
                    minimumWidth: Int? = nil,
                    maximumWidth: Int? = nil) {
            self.alignment = alignment
            self.header = header
            self.maximumWidth = maximumWidth
            self.minimumWidth = minimumWidth
            self.values = values
        }

        // MARK: Public Instance Properties

        public var alignment: Alignment?
        public var header: String?
        public var maximumWidth: Int?
        public var minimumWidth: Int?
        public var values: [String]
    }
}

public extension Table.Column {

    // MARK: Public Instance Properties

    var isEmpty: Bool {
        values.isEmpty
    }

    // MARK: Public Instance Methods

    mutating func append(_ value: String) {
        values.append(value)
    }

    mutating func extend(to count: Int) {
        let padCount = count - values.count

        guard padCount > 0
        else { return }

        values += Array(repeating: "",
                        count: padCount)
    }
}

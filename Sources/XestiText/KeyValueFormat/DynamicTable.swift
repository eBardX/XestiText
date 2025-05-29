// © 2018–2025 John Gary Pusey (see LICENSE.md)

public struct DynamicTable: Sendable {

    // MARK: Public Initializers

    public init() {
        self.nameColumn = .init()
        self.valueColumn = .init()
    }

    // MARK: Public Instance Properties

    public var nameColumn: DynamicTableColumn
    public var valueColumn: DynamicTableColumn

    public var columns: [DynamicTableColumn] {
        [nameColumn, valueColumn]
    }

    public var isEmpty: Bool {
        nameColumn.isEmpty && valueColumn.isEmpty
    }

    // MARK: Public Instance Methods

    public mutating func append(_ name: String,
                                _ value: Any) {
        var names = nameColumn.values
        var values = valueColumn.values

        guard names.count == values.count
        else { fatalError("Bad table!") }

        names.append(name)
        values.append(String(describing: value))

        nameColumn.values = names
        valueColumn.values = values
    }

    public func render(box: String.Box = .plain) -> String {
        DynamicTableRenderer(self).render(box: box)
    }
}

// © 2018–2025 John Gary Pusey (see LICENSE.md)

public struct DynamicTableColumn: Sendable {

    // MARK: Public Initializers

    public init() {
        self.values = []
    }

    // MARK: Public Instance Properties

    public var values: [String]

    public var isEmpty: Bool {
        values.isEmpty
    }
}

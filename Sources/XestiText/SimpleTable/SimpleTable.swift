// © 2025 John Gary Pusey (see LICENSE.md)

public struct SimpleTable: Sendable {

    // MARK: Public Initializers

    public init(configuration: Configuration,
                headerTitle: Entry? = nil,
                columnTitles: [Entry]? = nil,
                rowValues: [[Entry]]) {
        precondition(Self._isValid(configuration,
                                   columnTitles,
                                   rowValues))

        self.columnTitles = columnTitles
        self.configuration = configuration
        self.headerTitle = headerTitle
        self.rowValues = rowValues
    }

    // MARK: Public Instance Properties

    public let columnTitles: [Entry]?
    public let configuration: Configuration
    public let headerTitle: Entry?
    public let rowValues: [[Entry]]

    public func render(using box: String.Box = .plain) -> String {
        Renderer.render(table: self,
                        using: box)
    }

    // MARK: Private Type Methods

    private static func _isValid(_ configuration: Configuration,
                                 _ columnTitles: [Entry]?,
                                 _ rowValues: [[Entry]]) -> Bool {
        let count = configuration.columns.count

        if let columnTitles {
            guard columnTitles.count == count
            else { return false }
        }

        return !rowValues.isEmpty && rowValues.allSatisfy { $0.count == count }
    }
}

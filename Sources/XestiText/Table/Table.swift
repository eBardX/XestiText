// © 2025 John Gary Pusey (see LICENSE.md)

public struct Table {

    // MARK: Public Initializers

    public init(configuration: Configuration,
                headerTitle: Entry? = nil,
                columnTitles: [Entry]? = nil,
                rows: [Row]) {
        precondition(Self._isValid(configuration,
                                   columnTitles,
                                   rows))

        self.columnTitles = columnTitles
        self.configuration = configuration
        self.headerTitle = headerTitle
        self.rows = rows
    }

    // MARK: Public Instance Properties

    public let columnTitles: [Entry]?
    public let configuration: Configuration
    public let headerTitle: Entry?
    public let rows: [Row]

    public func render(using box: String.Box = .plain) -> String {
        Renderer.render(table: self,
                        using: box)
    }

    // MARK: Private Type Methods

    private static func _isValid(_ configuration: Configuration,
                                 _ columnTitles: [Entry]?,
                                 _ rows: [Row]) -> Bool {
        let count = configuration.columns.count

        if let columnTitles {
            guard columnTitles.count == count
            else { return false }
        }

        guard !rows.isEmpty
        else { return false }

        for row in rows {
            switch row {
            case .separator:
                break

            case let .values(values):
                guard values.count == count
                else { return false }
            }
        }

        return true
    }
}

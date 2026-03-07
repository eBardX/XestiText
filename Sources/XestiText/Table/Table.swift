// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A text table.
public struct Table {

    // MARK: Public Initializers

    /// Creates a new, readonly table instance with the provided configuration,
    /// titles, and cell data.
    ///
    /// - Parameter configuration:  A ``Configuration`` instance supplying
    ///                             header and column options for the table.
    /// - Parameter headerTitle:    An optional ``Entry`` instance providing the
    ///                             title text and alignment for the table
    ///                             header. By default, this value is `nil`,
    ///                             meaning there is no header title.
    /// - Parameter columnTitles:   An optional array of ``Entry`` instances
    ///                             providing the title text and alignment for
    ///                             each column in the table. By default, this
    ///                             value is `nil`, meaning there are no column
    ///                             titles.
    /// - Parameter rows:           An array of ``Row`` instances providing the
    ///                             cell data for each row in the table.
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

    /// The optional array of ``Entry`` instances providing the title text and
    /// alignment for each column in the table.
    public let columnTitles: [Entry]?

    /// The ``Configuration`` instance supplying header and column options for
    /// the table.
    public let configuration: Configuration

    /// The optional ``Entry`` instance providing the title text and alignment
    /// for the table header.
    public let headerTitle: Entry?

    /// The array of ``Row`` instances providing the cell data for each row in
    /// the table.
    public let rows: [Row]

    // MARK: Public Instance Methods

    /// Renders the table into a string.
    ///
    /// - Parameter box:    The box-drawing characters to use to frame the
    ///                     rendered table.
    ///
    /// - Returns:  The rendered table.
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

// MARK: - Sendable

extension Table: Sendable {
}

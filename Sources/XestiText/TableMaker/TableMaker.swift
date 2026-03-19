// © 2025–2026 John Gary Pusey (see LICENSE.md)

/// A convenience structure that constructs a ``Table`` instance from
/// accumulated row data in accordance with an array of column descriptions.
///
/// Because a ``Table`` instance is readonly, it requires that all configuration
/// parameters, as well as all row data, be provided at creation time. This can
/// be challenging, especially when the exact configuration of the table (or its
/// data or both) may not be known all at once. `TableMaker` eases that burden
/// by allowing you to accumulate the data one row at a time.
public struct TableMaker {

    // MARK: Public Initializers

    /// Creates a new, _single-use_ `TableMaker` instance with the provided
    /// column descriptions, as well as optionally specified width limits.
    ///
    /// - Parameter columns:        An array of ``Column`` instances describing
    ///                             the columns in the table to be constructed.
    /// - Parameter minimumWidth:   The minimum width of the table to be
    ///                             constructed. If this value is `nil`,
    ///                             ``Limits/minimumTableWidth`` is used.
    ///                             Defaults to `nil`.
    /// - Parameter maximumWidth:   The maximum width of the table to be
    ///                             constructed. If this value is `nil`,
    ///                             ``Formatter/terminalWidth()`` is used.
    ///                             Defaults to `nil`.
    public init(columns: [Column] = [],
                minimumWidth: Int? = nil,
                maximumWidth: Int? = nil) {
        precondition(!columns.isEmpty)

        let termWidth = Formatter.terminalWidth()

        self.columns = columns
        self.maximumWidth = min(maximumWidth ?? termWidth, termWidth)
        self.minimumWidth = max(minimumWidth ?? Limits.minimumTableWidth,
                                Limits.minimumTableWidth)
        self.rows = []
    }

    // MARK: Public Instance Properties

    /// The array of ``Column`` instances describing the columns in the table to
    /// be constructed.
    public let columns: [Column]

    /// The maximum width of the table to be constructed.
    public let maximumWidth: Int

    /// The minimum width of the table to be constructed.
    public let minimumWidth: Int

    /// A Boolean value indicating whether the table maker is empty of rows.
    public var isEmpty: Bool {
        rows.isEmpty
    }

    // MARK: Public Instance Methods

    /// Appends a new row of values to the table maker.
    ///
    /// Each value in the provided array supplies the data for a single table
    /// cell. If the array contains fewer values than ``columns``, `nil` is
    /// assumed for the remaining values. If the array contains more values than
    /// ``columns``, the excess values are silently ignored. A value can be
    /// either a string or `nil`, where `nil` indicates that there is “no data”
    /// for the corresponding table cell.
    ///
    /// - Parameter values: An array of values to populate a row.
    public mutating func append(_ values: [String?]) {
        var row: [Text?] = []

        for (idx, options) in columns.enumerated() {
            if idx < values.count,
               let text = values[idx] {
                row.append(Text(text,
                                options.alignment))
            } else {
                row.append(nil)
            }
        }

        rows.append(row)
    }

    /// Appends the rows from another table maker to this table maker.
    ///
    /// - Parameter maker:  The other table maker.
    public mutating func append(_ maker: Self) {
        for mrow in maker.rows {
            let values: [String?] = mrow.map {
                guard let text = $0
                else { return nil }

                return text.rawText
            }

            append(values)
        }
    }

    /// Constructs a new, readonly ``Table`` instance.
    ///
    /// - Returns:  The new table.
    public func make() -> Table {
        precondition(!isEmpty,
                     "There must be at least one row!")

        let columnWidths = _determineColumnWidths()
        let columns = columnWidths.map { Table.ColumnOptions(width: $0) }

        return Table(configuration: Table.Configuration(columns: columns),
                     rows: _convertRows(columnWidths))
    }

    // MARK: Private Type Methods

    private static func _decreaseColumnWidths(_ columnWidths: inout [Int],
                                              from fromWidth: Int,
                                              to toWidth: Int,
                                              min minColumnWidths: [Int]) {
        var width = fromWidth

        //
        // First pass, stay at or above minimum column widths:
        //
        while width > toWidth {
            let newWidth = _decrementColumnWidths(&columnWidths,
                                                  from: width,
                                                  to: toWidth,
                                                  min: minColumnWidths)

            guard width > newWidth
            else { break }

            width = newWidth
        }

        let loColumnWidths = Array(repeating: 1,
                                   count: minColumnWidths.count)

        //
        // Second pass, go down to lowest column width:
        //
        while width > toWidth {
            let newWidth = _decrementColumnWidths(&columnWidths,
                                                  from: width,
                                                  to: toWidth,
                                                  min: loColumnWidths)

            guard width > newWidth
            else { break }

            width = newWidth
        }
    }

    private static func _decrementColumnWidths(_ columnWidths: inout [Int],
                                               from fromWidth: Int,
                                               to toWidth: Int,
                                               min minColumnWidths: [Int]) -> Int {
        precondition(minColumnWidths.count == columnWidths.count)

        var width = fromWidth

        for index in 0..<minColumnWidths.count {
            guard width > toWidth
            else { break }

            if columnWidths[index] > minColumnWidths[index] {
                columnWidths[index] -= 1
                width -= 1
            }
        }

        return width
    }

    private static func _increaseColumnWidths(_ columnWidths: inout [Int],
                                              from fromWidth: Int,
                                              to toWidth: Int,
                                              max maxColumnWidths: [Int]) {
        var width = fromWidth

        //
        // First pass, stay at or below maximum column widths:
        //
        while width < toWidth {
            let newWidth = _incrementColumnWidths(&columnWidths,
                                                  from: width,
                                                  to: toWidth,
                                                  max: maxColumnWidths)

            guard width < newWidth
            else { break }

            width = newWidth
        }

        let hiColumnWidths = Array(repeating: toWidth,
                                   count: maxColumnWidths.count)

        //
        // Second pass, go up to highest column width:
        //
        while width < toWidth {
            let newWidth = _incrementColumnWidths(&columnWidths,
                                                  from: width,
                                                  to: toWidth,
                                                  max: hiColumnWidths)

            guard width < newWidth
            else { break }

            width = newWidth
        }
    }

    private static func _incrementColumnWidths(_ columnWidths: inout [Int],
                                               from fromWidth: Int,
                                               to toWidth: Int,
                                               max maxColumnWidths: [Int]) -> Int {
        precondition(maxColumnWidths.count == columnWidths.count)

        var width = fromWidth

        for index in 0..<maxColumnWidths.count {
            guard width < toWidth
            else { break }

            if columnWidths[index] < maxColumnWidths[index] {
                columnWidths[index] += 1
                width += 1
            }
        }

        return width
    }

    // MARK: Private Instance Properties

    private var rows: [[Text?]]

    // MARK: Private Instance Methods

    private func _convertCells(_ cells: [Text?],
                               _ columnWidths: [Int]) -> [Table.Row] {
        guard !cells.allSatisfy({ $0 == nil })
        else { return [.separator] }

        let text: [[String]] = zip(cells, columnWidths).map { $0.0?.format(for: $0.1) ?? [] }
        let maxHeight = text.reduce(0) { max($0, $1.count) }

        var outRows: [Table.Row] = []

        for lineIndex in 0..<maxHeight {
            var outValues: [Table.Entry] = []

            for cellIndex in 0..<cells.count {
                let lines = text[cellIndex]

                if lineIndex < lines.count {
                    outValues.append(Table.Entry(lines[lineIndex]))
                } else {
                    outValues.append(Table.Entry(" ".repeating(to: columnWidths[cellIndex])))
                }
            }

            outRows.append(.values(outValues))
        }

        return outRows
    }

    private func _convertRows(_ columnWidths: [Int]) -> [Table.Row] {
        var tmpRows: [Table.Row] = []

        for row in rows {
            tmpRows.append(contentsOf: _convertCells(row, columnWidths))
        }

        //
        // Compress runs of separators (and drop leading/trailing separators):
        //
        var outRows: [Table.Row] = []
        var inRun = true

        for row in tmpRows {
            switch row {
            case .separator:
                if !inRun {
                    outRows.append(row)
                    inRun = true
                }

            case .values:
                outRows.append(row)
                inRun = false
            }
        }

        if inRun && !outRows.isEmpty {
            return outRows.dropLast()
        }

        return outRows
    }

    private func _determineColumnWidths() -> [Int] {
        let chromeWidth = max((columns.count * 3) + 1, 4)
        let maxTableWidth = maximumWidth
        let minTableWidth = min(columns.count + chromeWidth,
                                maxTableWidth)
        let maxColumnWidths = columns.map { $0.maximumWidth }
        let minColumnWidths = columns.map { $0.minimumWidth }

        var columnWidths = minColumnWidths

        for row in rows {
            for (cidx, entry) in row.enumerated() {
                let width = _clamp(minColumnWidths[cidx],
                                   entry?.maximumLineWidth ?? 0,
                                   maxColumnWidths[cidx])

                if columnWidths[cidx] < width {
                    columnWidths[cidx] = width
                }
            }
        }

        let totalWidth = columnWidths.reduce(0, +)
        let avgColumnWidth = totalWidth / columnWidths.count

        for idx in 0..<minColumnWidths.count where minColumnWidths[idx] > avgColumnWidth {
            columnWidths[idx] = avgColumnWidth
        }

        let tableWidthC = totalWidth + chromeWidth
        let tableWidth = _clamp(minTableWidth,
                                tableWidthC,
                                maxTableWidth)

        if tableWidth > tableWidthC {
            Self._increaseColumnWidths(&columnWidths,
                                       from: tableWidthC - chromeWidth,
                                       to: tableWidth - chromeWidth,
                                       max: maxColumnWidths)
        } else if tableWidth < tableWidthC {
            Self._decreaseColumnWidths(&columnWidths,
                                       from: tableWidthC - chromeWidth,
                                       to: tableWidth - chromeWidth,
                                       min: minColumnWidths)
        }

        return columnWidths
    }
}

// MARK: - Sendable

extension TableMaker: Sendable {
}

// MARK: -

private func _clamp<T>(_ vmin: T,
                       _ value: T,
                       _ vmax: T) -> T
where T: Comparable {
    vmin > value ? vmin : vmax < value ? vmax : value
}

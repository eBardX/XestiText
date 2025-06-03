// © 2025 John Gary Pusey (see LICENSE.md)

public final class TableMaker {

    // MARK: Public Initializers

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

    public let columns: [Column]
    public let maximumWidth: Int
    public let minimumWidth: Int

    public var isEmpty: Bool {
        rows.isEmpty
    }

    // MARK: Public Instance Methods

    public func append(_ values: [String?]) {
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

    public func make() -> Table {
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
        var outRows: [Table.Row] = []

        for row in rows {
            outRows.append(contentsOf: _convertCells(row, columnWidths))
        }

        while case .separator = outRows.last {
            outRows = Array(outRows.dropLast())
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

// MARK: -

private func _clamp<T>(_ vmin: T,
                       _ value: T,
                       _ vmax: T) -> T
where T: Comparable {
    vmin > value ? vmin : vmax < value ? vmax : value
}

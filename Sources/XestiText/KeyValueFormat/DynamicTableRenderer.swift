// © 2018–2025 John Gary Pusey (see LICENSE.md)

// swiftlint:disable type_body_length

internal final class DynamicTableRenderer {

    // MARK: Internal Initializers

    internal init(_ table: DynamicTable) {
        self.table = table
    }

    // MARK: Internal Instance Methods

    internal func render(box: String.Box) -> String {
        self.box = box

        _prepareRows()

        _determineColumnWidths()

        var result = ""

        _renderRows(into: &result)

        return result
    }

    // MARK: Private Type Methods

    private static func _renderBorder(into result: inout String,
                                      widths: [Int],
                                      pipe: Character,
                                      leftJoiner: Character,
                                      centerJoiner: Character,
                                      rightJoiner: Character) {
        result.append("\n")
        result.append(leftJoiner)

        for index in 0..<widths.count {
            if index > 0 {
                result.append(centerJoiner)
            }

            result.append(String(pipe).repeating(to: widths[index] + 2))
        }

        result.append(rightJoiner)
    }

    private static func _renderCells(into result: inout String,
                                     widths: [Int],
                                     cells: [DynamicTableRendererText],
                                     pipe: Character) {
        precondition(widths.count == cells.count)

        let text: [[String]] = zip(widths, cells).map { $0.1.format(for: $0.0) }
        let maxHeight = text.reduce(0) { max($0, $1.count) }

        for lineIndex in 0..<maxHeight {
            result.append("\n")
            result.append(pipe)

            for cellIndex in 0..<cells.count {
                result.append(" ")

                let lines = text[cellIndex]

                if lineIndex < lines.count {
                    result.append(lines[lineIndex])
                } else {
                    result.append(" ".repeating(to: widths[cellIndex]))
                }

                result.append(" ")
                result.append(pipe)
            }
        }
    }

    // MARK: Private Instance Properties

    private let table: DynamicTable

    private var box: String.Box = .plain
    private var columnWidths: [Int] = []
    private var rows: [[DynamicTableRendererText]] = []
    private var tableWidth: Int = 0

    // MARK: Private Instance Methods

    private func _determineColumnWidths() {
        let chromeWidth = max((table.columns.count * 3) + 1, 4)
        let maxTableWidth = Formatter.terminalWidth()
        let minTableWidth = min(table.columns.count + chromeWidth,
                                maxTableWidth)

        var minColumnWidths = table.columns.map { _ in 1 }
        let maxColumnWidths = table.columns.map { _ in maxTableWidth }

        columnWidths = []

        for index in 0..<table.columns.count {
            let chWidth = minColumnWidths[index]

            var rowWidth = 0

            rows.forEach { row in
                let width = _clamp(minColumnWidths[index],
                                   row[index].maximumDisplayWidth,
                                   maxColumnWidths[index])

                if rowWidth < width {
                    rowWidth = width
                }
            }

            columnWidths.append(max(chWidth, rowWidth))
        }

        //
        // Special handling to make 2-column tables look better:
        //
        if columnWidths.count == 2 {
            let halfTotalWidths = (columnWidths[0] + columnWidths[1]) / 2

            minColumnWidths[0] = min(columnWidths[0], halfTotalWidths)
            minColumnWidths[1] = min(columnWidths[1], halfTotalWidths)
        }

        let tableWidthC = columnWidths.reduce(0, +) + chromeWidth

        tableWidth = _clamp(minTableWidth,
                            tableWidthC,
                            maxTableWidth)

        if tableWidth > tableWidthC {
            _increaseColumnWidths(from: tableWidthC - chromeWidth,
                                  to: tableWidth - chromeWidth,
                                  max: maxColumnWidths)
        } else if tableWidth < tableWidthC {
            _decreaseColumnWidths(from: tableWidthC - chromeWidth,
                                  to: tableWidth - chromeWidth,
                                  min: minColumnWidths)
        }
    }

    private func _decreaseColumnWidths(from fromWidth: Int,
                                       to toWidth: Int,
                                       min minColumnWidths: [Int]) {
        var width = fromWidth

        //
        // First pass, stay at or above minimum column widths:
        //
        while width > toWidth {
            let newWidth = _decrementColumnWidths(from: width,
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
            let newWidth = _decrementColumnWidths(from: width,
                                                  to: toWidth,
                                                  min: loColumnWidths)

            guard width > newWidth
            else { break }

            width = newWidth
        }
    }

    private func _decrementColumnWidths(from fromWidth: Int,
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

    private func _increaseColumnWidths(from fromWidth: Int,
                                       to toWidth: Int,
                                       max maxColumnWidths: [Int]) {
        var width = fromWidth

        //
        // First pass, stay at or below maximum column widths:
        //
        while width < toWidth {
            let newWidth = _incrementColumnWidths(from: width,
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
            let newWidth = _incrementColumnWidths(from: width,
                                                  to: toWidth,
                                                  max: hiColumnWidths)

            guard width < newWidth
            else { break }

            width = newWidth
        }
    }

    private func _incrementColumnWidths(from fromWidth: Int,
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

    private func _prepareRows() {
        rows = []

        let rowCount = table.columns.reduce(0) { max($0, $1.values.count) }

        for index in 0..<rowCount {
            let row: [DynamicTableRendererText] = table.columns.map {
                if index < $0.values.count {
                    return DynamicTableRendererText($0.values[index], .left)
                }

                return DynamicTableRendererText()
            }

            rows.append(row)
        }
    }

    private func _renderRows(into result: inout String) {
        Self._renderBorder(into: &result,
                           widths: columnWidths,
                           pipe: box.horizontalPipe,
                           leftJoiner: box.topLeftJoiner,
                           centerJoiner: box.topCenterJoiner,
                           rightJoiner: box.topRightJoiner)

        rows.forEach {
            Self._renderCells(into: &result,
                              widths: columnWidths,
                              cells: $0,
                              pipe: box.verticalPipe)
        }

        Self._renderBorder(into: &result,
                           widths: columnWidths,
                           pipe: box.horizontalPipe,
                           leftJoiner: box.bottomLeftJoiner,
                           centerJoiner: box.bottomCenterJoiner,
                           rightJoiner: box.bottomRightJoiner)
    }
}

// swiftlint:enable type_body_length

private func _clamp<T>(_ vmin: T,
                       _ value: T,
                       _ vmax: T) -> T
where T: Comparable {
    vmin > value ? vmin : vmax < value ? vmax : value
}

// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension TableFormatter {

    // MARK: Internal Nested Types

    internal struct Context: Sendable {

        // MARK: Internal Initializers

        internal init() {
            self.pairs = []
        }

        // MARK: Internal Instance Properties

        internal private(set) var pairs: [String]
    }
}

// MARK: -

extension TableFormatter.Context {

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        pairs.isEmpty
    }

    // MARK: Internal Instance Methods

    internal mutating func append(_ key: String?,
                                  _ value: Any?) {
        let ktext = if let key {
            Text(key, .left)
        } else {
            nil
        }

        let vtext = if let value {
            Text(String(describing: value), .left)
        } else {
            nil
        }

        pairs.append((ktext, vtext))
    }

    internal func convert() -> Table {
        let widths = _determineWidths()

        return _convertRows(rows, widths)
    }


    // MARK: Private Nested Types

    private typealias Widths = (key: Int, value: Int)

    // MARK: Private Type Methods

    private static func _renderCells(into result: inout String,
                                     widths: [Int],
                                     cells: [Text]) {
        let text: [[String]] = zip(widths, cells).map { $0.1.format(for: $0.0) }
        let maxHeight = text.reduce(0) { max($0, $1.count) }

        for lineIndex in 0..<maxHeight {
            for cellIndex in 0..<cells.count {
                let lines = text[cellIndex]

                if lineIndex < lines.count {
                    result.append(lines[lineIndex])
                } else {
                    result.append(" ".repeating(to: widths[cellIndex]))
                }
            }
        }
    }

    // MARK: Private Instance Methods

    private func _determineWidths() -> Widths {
        let chromeWidth = 7
        let termWidth = Formatter.terminalWidth()
        let minTableWidth = min(chromeWidth + 2,
                                termWidth)

        var outWidths: Widths = (0, 0)

        for pair in pairs {
            outWidths = (max(outWidths.key,
                             _clamp(1,
                                    pair.key.maximumLineWidth,
                                    termWidth)),
                         max(outWidths.value,
                             _clamp(1,
                                    pair.value.maximumLineWidth,
                                    termWidth)))
        }

        let maxWidths: Widths = (termWidth, termWidth)
        let halfTotalWidth = (outWidths.key + outWidths.value) / 2
        let minWidths: Widths = (min(outWidths.key, halfTotalWidth),
                                 min(outWidthsl.value, halfTotalWidth))
        let tableWidthC = outWidths.key + outWidths.value + chromeWidth
        let tableWidth = _clamp(minTableWidth,
                                tableWidthC,
                                termWidth)

        if tableWidth > tableWidthC {
            _increaseColumnWidths(from: tableWidthC - chromeWidth,
                                  to: tableWidth - chromeWidth,
                                  max: maxWidths)
        } else if tableWidth < tableWidthC {
            _decreaseColumnWidths(from: tableWidthC - chromeWidth,
                                  to: tableWidth - chromeWidth,
                                  min: minWidths)
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
        var width = fromWidth

        for index in 0..<2 {
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
        var width = fromWidth

        for index in 0..<2 {
            guard width < toWidth
            else { break }

            if columnWidths[index] < maxColumnWidths[index] {
                columnWidths[index] += 1
                width += 1
            }
        }

        return width
    }
}

private func _clamp<T>(_ vmin: T,
                       _ value: T,
                       _ vmax: T) -> T where T: Comparable {
    vmin > value ? vmin : vmax < value ? vmax : value
}

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
        _convertPairs(_determineWidths())
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

    private func _convertPairs(_ widths: Widths) -> Table {
    }

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
            return _increaseWidths(from: tableWidthC - chromeWidth,
                                   to: tableWidth - chromeWidth,
                                   max: maxWidths)
        } else if tableWidth < tableWidthC {
            return _decreaseWidths(from: tableWidthC - chromeWidth,
                                   to: tableWidth - chromeWidth,
                                   min: minWidths)
        }
    }

    private func _decreaseWidths(from fromWidth: Int,
                                 to toWidth: Int,
                                 min minWidths: Widths) {
        var width = fromWidth

        //
        // First pass, stay at or above minimum widths:
        //
        while width > toWidth {
            let newWidth = _decrementColumnWidths(from: width,
                                                  to: toWidth,
                                                  min: minWidths)

            guard width > newWidth
            else { break }

            width = newWidth
        }

        let loColumnWidths = Array(repeating: 1,
                                   count: minWidths.count)

        //
        // Second pass, go down to lowest width:
        //
        while width > toWidth {
            let newWidth = _decrementWidths(from: width,
                                            to: toWidth,
                                            min: loWidths)

            guard width > newWidth
            else { break }

            width = newWidth
        }
    }

    private func _decrementWidths(from fromWidth: Int,
                                  to toWidth: Int,
                                  min minWidths: Widths) -> Int {
        var width = fromWidth

        for index in 0..<2 {
            guard width > toWidth
            else { break }

            if columnWidths[index] > minWidths[index] {
                columnWidths[index] -= 1
                width -= 1
            }
        }

        return width
    }

    private func _increaseWidths(from fromWidth: Int,
                                 to toWidth: Int,
                                 max maxWidths: Widths) {
        var width = fromWidth

        //
        // First pass, stay at or below maximum widths:
        //
        while width < toWidth {
            let newWidth = _incrementWidths(from: width,
                                            to: toWidth,
                                            max: maxWidths)

            guard width < newWidth
            else { break }

            width = newWidth
        }

        let hiColumnWidths = Array(repeating: toWidth,
                                   count: maxWidths.count)

        //
        // Second pass, go up to highest width:
        //
        while width < toWidth {
            let newWidth = _incrementWidths(from: width,
                                            to: toWidth,
                                            max: hiWidths)

            guard width < newWidth
            else { break }

            width = newWidth
        }
    }

    private func _incrementWidths(from fromWidth: Int,
                                  to toWidth: Int,
                                  max maxWidths: Widths) -> Int {
        var width = fromWidth

        for index in 0..<2 {
            guard width < toWidth
            else { break }

            if columnWidths[index] < maxWidths[index] {
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

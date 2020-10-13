// © 2018–2020 J. G. Pusey (see LICENSE.md)

// swiftlint:disable type_body_length

internal class TableRenderer {

    // MARK: Internal Initializers

    internal init(_ table: Table) {
        self.table = table
    }

    // MARK: Internal Instance Methods

    internal func render(box: Table.Box = .plain) -> String {
        self.box = box

        _prepareHeader()
        _prepareColumnHeaders()
        _prepareRows()
        _prepareFooter()

        _determineColumnWidths()

        var result = ""

        _renderHeader(into: &result)
        _renderColumnHeaders(into: &result)
        _renderRows(into: &result)
        _renderFooter(into: &result)

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

            result.append(String(pipe).repeat(widths[index] + 2))
        }

        result.append(rightJoiner)
    }

    private static func _renderCells(into result: inout String,
                                     widths: [Int],
                                     cells: [Text],
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
                    result.append(" ".repeat(widths[cellIndex]))
                }

                result.append(" ")
                result.append(pipe)
            }
        }
    }

    // MARK: Private Instance Properties

    private let table: Table

    private var box: Table.Box = .plain
    private var columnHeaders: [Text] = []
    private var columnWidths: [Int] = []
    private var footer = Text()
    private var hasColumnHeaders: Bool = false
    private var hasFooter: Bool = false
    private var hasHeader: Bool = false
    private var header = Text()
    private var rows: [[Text]] = []
    private var tableWidth: Int = 0

    // MARK: Private Instance Methods

    private func _determineColumnWidths() {
        let chromeWidth = max((table.columns.count * 3) + 1, 4)
        let maxTableWidth = Format.terminalWidth()
        let minTableWidth = min(table.columns.count + chromeWidth,
                                maxTableWidth)

        var minColumnWidths = table.columns.map { $0.minimumWidth ?? 1 }
        let maxColumnWidths = table.columns.map { $0.maximumWidth ?? maxTableWidth }

        let tableWidthF = footer.maximumDisplayWidth + 4    // add in chrome
        let tableWidthH = header.maximumDisplayWidth + 4    // ditto

        columnWidths = []

        for index in 0..<table.columns.count {
            let chWidth: Int

            if hasColumnHeaders {
                chWidth = _clamp(minColumnWidths[index],
                                 columnHeaders[index].maximumDisplayWidth,
                                 maxColumnWidths[index])
            } else {
                chWidth = minColumnWidths[index]
            }

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
                            max(max(tableWidthF, tableWidthH),
                                tableWidthC),
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

            guard
                width > newWidth
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

            guard
                width > newWidth
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
            guard
                width > toWidth
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

            guard
                width < newWidth
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

            guard
                width < newWidth
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
            guard
                width < toWidth
                else { break }

            if columnWidths[index] < maxColumnWidths[index] {
                columnWidths[index] += 1
                width += 1
            }
        }

        return width
    }

    private func _prepareColumnHeaders() {
        hasColumnHeaders = false

        columnHeaders = table.columns.map {
            let text = Text($0.header,
                            $0.alignment ?? .left)

            if !text.isEmpty {
                hasColumnHeaders = true
            }

            return text
        }
    }

    private func _prepareFooter() {
        footer = Text(table.footer,
                      .left)

        hasFooter = !footer.isEmpty
    }

    private func _prepareHeader() {
        header = Text(table.header,
                      .center)

        hasHeader = !header.isEmpty
    }

    private func _prepareRows() {
        rows = []

        let rowCount = table.columns.reduce(0) { max($0, $1.values.count) }

        for index in 0..<rowCount {
            let row: [Text] = table.columns.map {
                if index < $0.values.count {
                    return Text($0.values[index],
                                $0.alignment ?? .left)
                } else {
                    return Text()
                }
            }

            rows.append(row)
        }
    }

    private func _renderColumnHeaders(into result: inout String) {
        guard
            hasColumnHeaders
            else { return }

        TableRenderer._renderBorder(into: &result,
                                    widths: columnWidths,
                                    pipe: box.h,
                                    leftJoiner: hasHeader ? box.vr : box.dr,
                                    centerJoiner: box.dh,
                                    rightJoiner: hasHeader ? box.vl : box.dl)

        TableRenderer._renderCells(into: &result,
                                   widths: columnWidths,
                                   cells: columnHeaders,
                                   pipe: box.v)
    }

    private func _renderFooter(into result: inout String) {
        guard
            hasFooter
            else { return }

        TableRenderer._renderCells(into: &result,
                                   widths: [tableWidth - 4],
                                   cells: [footer],
                                   pipe: box.v)

        TableRenderer._renderBorder(into: &result,
                                    widths: [tableWidth - 4],
                                    pipe: box.h,
                                    leftJoiner: box.ur,
                                    centerJoiner: box.uh,
                                    rightJoiner: box.ul)
    }

    private func _renderHeader(into result: inout String) {
        guard
            hasHeader
            else { return }

        TableRenderer._renderBorder(into: &result,
                                    widths: [tableWidth - 4],
                                    pipe: box.h,
                                    leftJoiner: box.dr,
                                    centerJoiner: box.dh,
                                    rightJoiner: box.dl)

        TableRenderer._renderCells(into: &result,
                                   widths: [tableWidth - 4],
                                   cells: [header],
                                   pipe: box.v)
    }

    private func _renderRows(into result: inout String) {
        TableRenderer._renderBorder(into: &result,
                                    widths: columnWidths,
                                    pipe: box.h,
                                    leftJoiner: (hasHeader || hasColumnHeaders) ? box.vr : box.dr,
                                    centerJoiner: hasColumnHeaders ? box.vh : box.dh,
                                    rightJoiner: (hasHeader || hasColumnHeaders) ? box.vl : box.dl)

        rows.forEach {
            TableRenderer._renderCells(into: &result,
                                       widths: columnWidths,
                                       cells: $0,
                                       pipe: box.v)
        }

        TableRenderer._renderBorder(into: &result,
                                    widths: columnWidths,
                                    pipe: box.h,
                                    leftJoiner: hasFooter ? box.vr : box.ur,
                                    centerJoiner: box.uh,
                                    rightJoiner: hasFooter ? box.vl : box.ul)
    }
}

internal class Text {

    // MARK: Internal Initializers

    internal init(_ rawText: String? = nil,
                  _ alignment: Table.Alignment = .center) {
        self.alignment = alignment
        self.lines = Text._splitIntoLines(rawText)
    }

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        return lines.isEmpty
    }

    internal var maximumDisplayWidth: Int {
        return lines.reduce(0) { max($0, $1.displayWidth) }
    }

    // MARK: Internal Instance Methods

    internal func format(for width: Int) -> [String] {
        return lines.flatMap { $0.wrap(width, splitWords: true) }.map { _pad($0, width) }
    }

    // MARK: Private Type Methods

    private static func _splitIntoLines(_ rawText: String?) -> [String] {
        guard
            let text = rawText
            else { return [] }

        return text
            .split(omittingEmptySubsequences: false) { $0.isNewline }   // swiftlint:disable:this multiline_arguments
            .map { String($0).compress() }
    }

    // MARK: Private Instance Properties

    private let alignment: Table.Alignment
    private let lines: [String]

    // MARK: Private Instance Methods

    private func _pad(_ text: String,
                      _ width: Int) -> String {
        let padWidth = width - text.displayWidth

        guard
            padWidth > 0
            else { return text }

        switch alignment {
        case .center:
            let padWidthL = padWidth / 2
            let padWidthR = padWidth - padWidthL

            return " ".repeat(padWidthL) + text + " ".repeat(padWidthR)

        case .left:
            return text + " ".repeat(padWidth)

        case .right:
            return " ".repeat(padWidth) + text
        }
    }
}

private func _clamp<T>(_ vmin: T,
                       _ value: T,
                       _ vmax: T) -> T
    where T: Comparable {
        return vmin > value ? vmin : vmax < value ? vmax : value
}

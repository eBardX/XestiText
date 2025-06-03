// © 2025 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Internal Nested Types

    internal enum Renderer {
    }
}

// MARK: -

extension Table.Renderer {

    // MARK: Internal Instance Methods

    internal static func render(table: Table,
                                using box: String.Box) -> String {
        var result = ""

        _renderHeaderTitle(of: table,
                           using: box,
                           into: &result)

        _renderColumnTitles(of: table,
                            using: box,
                            into: &result)

        _renderRowValues(of: table,
                         using: box,
                         into: &result)

        return result
    }

    // MARK: Private Nested Types

    private typealias Entry   = Table.Entry
    private typealias Options = Table.ColumnOptions

    // MARK: Private Type Methods

    private static func _renderBorder(options: [Options],
                                      pipe: Character,
                                      leftJoiner: Character,
                                      centerJoiners: [Character],
                                      rightJoiner: Character,
                                      into result: inout String) {
        result.append("\n")
        result.append(leftJoiner)

        for index in 0..<options.count {
            if index > 0 {
                result.append(centerJoiners[index - 1])
            }

            result.append(String(pipe).repeating(to: options[index].width + 2))
        }

        result.append(rightJoiner)
    }

    private static func _renderColumnTitles(of table: Table,
                                            using box: String.Box,
                                            into result: inout String) {
        guard let titles = table.columnTitles
        else { return }

        let columnCount = table.configuration.columns.count
        let cjCount = columnCount - 1

        var centerJoiners: [Character]
        var rightJoiner: Character
        var leftJoiner: Character

        if table.headerTitle != nil {
            let span = table.configuration.header.span

            leftJoiner = box.middleLeftJoiner

            centerJoiners = .init(repeating: box.topCenterJoiner,
                                  count: cjCount)

            if span < columnCount {
                rightJoiner = box.topRightJoiner

                centerJoiners[span - 1] = box.middleCenterJoiner
            } else {
                rightJoiner = box.middleRightJoiner
            }
        } else {
            leftJoiner = box.topLeftJoiner
            centerJoiners = .init(repeating: box.topCenterJoiner,
                                  count: cjCount)
            rightJoiner = box.topRightJoiner
        }

        _renderBorder(options: table.configuration.columns,
                      pipe: box.horizontalPipe,
                      leftJoiner: leftJoiner,
                      centerJoiners: centerJoiners,
                      rightJoiner: rightJoiner,
                      into: &result)

        _renderTitleEntries(titles,
                            options: table.configuration.columns,
                            pipe: box.verticalPipe,
                            into: &result)
    }

    private static func _renderHeaderTitle(of table: Table,
                                           using box: String.Box,
                                           into result: inout String) {
        guard let title = table.headerTitle
        else { return }

        let span = table.configuration.header.span
        let colWidths = table.configuration.columns.map { $0.width }

        var fauxWidth = 0

        for idx in 0..<span {
            fauxWidth += colWidths[idx]

            if idx > 0 {
                fauxWidth += 3
            }
        }

        let fauxOptions = Options(width: fauxWidth,
                                  titleAlignment: table.configuration.header.alignment)

        _renderBorder(options: [fauxOptions],
                      pipe: box.horizontalPipe,
                      leftJoiner: box.topLeftJoiner,
                      centerJoiners: [],
                      rightJoiner: box.topRightJoiner,
                      into: &result)

        _renderTitleEntries([title],
                            options: [fauxOptions],
                            pipe: box.verticalPipe,
                            into: &result)
    }

    private static func _renderRowValues(of table: Table,
                                         using box: String.Box,
                                         into result: inout String) {
        let columnCount = table.configuration.columns.count
        let cjCount = columnCount - 1

        var centerJoiners: [Character]
        var rightJoiner: Character
        var leftJoiner: Character

        if table.columnTitles != nil {
            leftJoiner = box.middleLeftJoiner
            centerJoiners = .init(repeating: box.middleCenterJoiner,
                                  count: cjCount)
            rightJoiner = box.middleRightJoiner
        } else if table.headerTitle != nil {
            let span = table.configuration.header.span

            leftJoiner = box.middleLeftJoiner

            centerJoiners = .init(repeating: box.topCenterJoiner,
                                  count: cjCount)

            if span < columnCount {
                rightJoiner = box.topRightJoiner

                centerJoiners[span - 1] = box.middleCenterJoiner
            } else {
                rightJoiner = box.middleRightJoiner
            }
        } else {
            leftJoiner = box.topLeftJoiner
            centerJoiners = .init(repeating: box.topCenterJoiner,
                                  count: cjCount)
            rightJoiner = box.topRightJoiner
        }

        _renderBorder(options: table.configuration.columns,
                      pipe: box.horizontalPipe,
                      leftJoiner: leftJoiner,
                      centerJoiners: centerJoiners,
                      rightJoiner: rightJoiner,
                      into: &result)

        centerJoiners = .init(repeating: box.middleCenterJoiner,
                              count: cjCount)

        for row in table.rows {
            switch row {
            case .separator:
                _renderBorder(options: table.configuration.columns,
                              pipe: box.horizontalPipe,
                              leftJoiner: box.middleLeftJoiner,
                              centerJoiners: centerJoiners,
                              rightJoiner: box.middleRightJoiner,
                              into: &result)

            case let .values(valueEntries):
                _renderValueEntries(valueEntries,
                                    options: table.configuration.columns,
                                    pipe: box.verticalPipe,
                                    into: &result)
            }
        }

        centerJoiners = .init(repeating: box.bottomCenterJoiner,
                              count: cjCount)

        _renderBorder(options: table.configuration.columns,
                      pipe: box.horizontalPipe,
                      leftJoiner: box.bottomLeftJoiner,
                      centerJoiners: centerJoiners,
                      rightJoiner: box.bottomRightJoiner,
                      into: &result)
    }

    private static func _renderTitleEntries(_ entries: [Entry],
                                            options: [Options],
                                            pipe: Character,
                                            into result: inout String) {
        result.append("\n")
        result.append(pipe)

        for index in 0..<options.count {
            result.append(" ")

            let copts = options[index]
            let entry = entries[index]
            let text = entry.text.fitting(to: copts.width,
                                          alignment: entry.alignment ?? copts.titleAlignment)

            result.append(text)
            result.append(" ")
            result.append(pipe)
        }
    }

    private static func _renderValueEntries(_ entries: [Entry],
                                            options: [Options],
                                            pipe: Character,
                                            into result: inout String) {
        result.append("\n")
        result.append(pipe)

        for index in 0..<options.count {
            result.append(" ")

            let copts = options[index]
            let entry = entries[index]
            let text = entry.text.fitting(to: copts.width,
                                          alignment: entry.alignment ?? copts.valueAlignment)

            result.append(text)
            result.append(" ")
            result.append(pipe)
        }
    }
}

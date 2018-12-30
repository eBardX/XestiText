// © 2018 J. G. Pusey (see LICENSE.md)

public final class TableFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    public init() {
        self.table = .init()
    }

    // MARK: Public Instance Methods

    public func add(_ key: String,
                    _ value: Any) {
        switch value {
        case let values as [KeyValueFormattable]:
            add(key, values)

        case let values as [Any]:
            add(key, values)

        case let value as KeyValueFormattable:
            add(key, [value])

        default:
            table.append(key, value)
        }
    }

    public func format() -> String {
        return table.render()
    }

    // MARK: Private Instance Properties

    private var table: Table

    // MARK: Private Instance Methods

    private func add(_ key: String,
                     _ values: [Any]) {
        var first = true

        for value in values {
            table.append(first ? key : "", value)

            first = false
        }
    }

    private func add(_ key: String,
                     _ values: [KeyValueFormattable]) {
        for value in values {
            table.append("", "")

            value.format(with: self)
        }
    }
}

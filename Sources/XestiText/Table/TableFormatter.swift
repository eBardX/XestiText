// © 2018–2025 John Gary Pusey (see LICENSE.md)

public final class TableFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    public init(_ box: Table.Box = .plain) {
        self.box = box
        self.table = .init()
    }

    // MARK: Public Instance Methods

    public func add(_ key: String,
                    _ value: Any) {
        switch value {
        case let values as [any KeyValueFormattable]:
            _add(key, values)

        case let values as [Any]:
            _add(key, values)

        case let value as any KeyValueFormattable:
            _add(key, [value])

        default:
            table.append(key, value)
        }
    }

    public func format() -> String {
        table.render(box: box)
    }

    // MARK: Private Instance Properties

    private var box: Table.Box
    private var table: Table

    // MARK: Private Instance Methods

    private func _add(_ key: String,
                      _ values: [Any]) {
        var first = true

        for value in values {
            table.append(first ? key : "", value)

            first = false
        }
    }

    private func _add(_ key: String,
                      _ values: [any KeyValueFormattable]) {
        for value in values {
            if !table.isEmpty {
                table.append("", "")
            }

            value.format(with: self)
        }
    }
}

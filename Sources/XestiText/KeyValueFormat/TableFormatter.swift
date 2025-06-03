// © 2018–2025 John Gary Pusey (see LICENSE.md)

public final class TableFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    public init(_ box: String.Box = .plain) {
        self.box = box
        self.maker = .init(columns: [.init(), .init()])
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
            _add(key, value)
        }
    }

    public func format() -> String {
        maker.make().render(using: box)
    }

    // MARK: Private Instance Properties

    private let box: String.Box
    private let maker: TableMaker

    // MARK: Private Instance Methods

    private func _add(_ key: String,
                      _ values: [Any]) {
        var first = true

        for value in values {
            _add(first ? key : "", value)

            first = false
        }
    }

    private func _add(_ key: String,
                      _ values: [any KeyValueFormattable]) {
        for value in values {
            if !maker.isEmpty {
                maker.append([nil, nil])
            }

            value.format(with: self)
        }
    }

    private func _add(_ key: String?,
                      _ value: Any?) {
        if let value {
            maker.append([key, String(describing: value)])
        } else {
            maker.append([key, nil])
        }
    }
}

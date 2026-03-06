// © 2018–2026 John Gary Pusey (see LICENSE.md)

public struct TableFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    public init(_ box: String.Box = .plain) {
        self.box = box
        self.maker = TableMaker(columns: [TableMaker.Column(),
                                          TableMaker.Column()])
    }

    // MARK: Public Instance Methods

    public mutating func add(_ key: String,
                             _ value: any Sendable) {
        switch value {
        case let values as [any KeyValueFormattable]:
            _add(key, values)

        case let values as [any Sendable]:
            _add(key, values)

        case let value as any KeyValueFormattable:
            _add(key, [value])

        default:
            _add(key, value)
        }
    }

    public mutating func addSeparator() {
        maker.append([nil, nil])
    }

    public func format() -> String {
        maker.make().render(using: box)
    }

    // MARK: Private Instance Properties

    private let box: String.Box

    private var maker: TableMaker

    // MARK: Private Instance Methods

    private mutating func _add(_ key: String,
                               _ values: [any Sendable]) {
        var first = true

        for value in values {
            _add(first ? key : "", value)

            first = false
        }
    }

    private mutating func _add(_ key: String,
                               _ values: [any KeyValueFormattable]) {
        var formatter = Self()

        for value in values {
            addSeparator()

            value.format(with: &formatter)
        }

        maker.append(formatter.maker)
    }

    private mutating func _add(_ key: String?,
                               _ value: (any Sendable)?) {
        if let value {
            maker.append([key, String(describing: value)])
        } else {
            maker.append([key, nil])
        }
    }
}

// MARK: -

extension TableFormatter: Sendable {
}

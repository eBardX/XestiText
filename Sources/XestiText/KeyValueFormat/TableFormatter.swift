// © 2018–2026 John Gary Pusey (see LICENSE.md)

/// A key-value formatter that accumulates key-value pairs and formats them into
/// a text table.
public struct TableFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    /// Creates a new, _single-use_ table formatter.
    ///
    /// Once a key-value pair has been added to the formatter, it cannot be
    /// removed or overwritten.
    ///
    /// - Parameter box:    The box-drawing characters to use to frame the
    ///                     formatted text table.
    public init(_ box: String.Box = .plain) {
        self.box = box
        self.maker = TableMaker(columns: [TableMaker.Column(),
                                          TableMaker.Column()])
    }

    // MARK: Public Instance Methods

    /// Adds the provided key and value to the table formatter as a key-value
    /// pair.
    ///
    /// - Parameter key:    The key to add to the table formatter.
    /// - Parameter value:  The value to add to the table formatter. The value
    ///                     can be `nil`.
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

    /// Adds a separator to the table formatter.
    ///
    /// The table formatter formats a separator as a row separator. It collapses
    /// multiple consecutive separators into a single row separator.
    public mutating func addSeparator() {
        maker.append([nil, nil])
    }

    /// Formats the accumulated key-value pairs into a text table.
    ///
    /// - Returns:  The formatted text table.
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

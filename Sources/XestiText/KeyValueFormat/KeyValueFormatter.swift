// © 2018–2025 John Gary Pusey (see LICENSE.md)

public protocol KeyValueFormatter: Sendable {
    mutating func add(_ key: String,
                      _ value: any Sendable)

    mutating func addIfPresent(_ key: String,
                               _ value: (any Sendable)?)

    mutating func addSeparator()

    func format() -> String
}

// MARK: -

extension KeyValueFormatter {
    public mutating func addIfPresent(_ key: String,
                                      _ value: (any Sendable)?) {
        if let value {
            add(key, value)
        }
    }

    public func addSeparator() {
    }
}

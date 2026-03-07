// © 2018–2026 John Gary Pusey (see LICENSE.md)

/// A type that can accumulate key-value pairs and format them into a string
/// representation.
public protocol KeyValueFormatter: Sendable {
    /// Adds the provided key and value to the key-value formatter as a
    /// key-value pair.
    ///
    /// - Parameter key:    The key to add to the key-value formatter.
    /// - Parameter value:  The value to add to the key-value formatter. The
    ///                     value can be `nil`.
    mutating func add(_ key: String,
                      _ value: any Sendable)

    /// Adds the provided key and value to the key-value formatter as a
    /// key-value pair, if the value is not `nil`.
    ///
    /// - Parameter key:    The key to add to the key-value formatter.
    /// - Parameter value:  The value to add to the key-value formatter. If the
    ///                     value is `nil`, neither the key nor the value is
    ///                     added.
    mutating func addIfPresent(_ key: String,
                               _ value: (any Sendable)?)

    /// Adds a separator to the key-value formatter.
    ///
    /// A key-value formatter is free to ignore any or all separators.
    mutating func addSeparator()

    /// Formats the accumulated key-value pairs into a string representation.
    ///
    /// - Returns:  The formatted textual representation.
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

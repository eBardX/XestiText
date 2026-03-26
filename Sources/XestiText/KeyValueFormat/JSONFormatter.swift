// © 2018–2026 John Gary Pusey (see LICENSE.md)

private import Foundation

/// A key-value formatter that accumulates key-value pairs and formats them into
/// a string of JSON data.
public struct JSONFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    /// Creates a new, _single-use_ JSON formatter.
    ///
    /// Once a key-value pair has been added to the formatter, it cannot be
    /// removed or overwritten.
    public init() {
        self.propertyList = [:]
    }

    // MARK: Public Instance Methods

    /// Adds the provided key and value to the JSON formatter as a key-value
    /// pair.
    ///
    /// - Parameter key:    The key to add to the JSON formatter.
    /// - Parameter value:  The value to add to the JSON formatter. The value
    ///                     can be `nil`.
    public mutating func add(_ key: String,
                             _ value: any Sendable) {
        switch value {
        case let values as [any KeyValueFormattable]:
            propertyList[key] = values.map { Self._convert($0) }

        case let value as any KeyValueFormattable:
            propertyList[key] = Self._convert(value)

        default:
            propertyList[key] = Self._convert(value)
        }
    }

    /// Formats the accumulated key-value pairs into a string of JSON data.
    ///
    /// - Returns:  The formatted string of JSON data. Returns an empty string
    ///             if JSON serialization or UTF-8 encoding fails.
    public func format() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: propertyList),
              let result = String(data: data,
                                  encoding: .utf8)
        else { return "" }

        return result
    }

    // MARK: Private Type Methods

    private static func _convert(_ value: (any Sendable)?) -> any Sendable {
        switch value {
        case .none:
            return NSNull()

        case let .some(value):
            if JSONSerialization.isValidJSONObject([value]) {
                return value
            }

            return String(describing: value)
        }
    }

    private static func _convert(_ value: some KeyValueFormattable) -> any Sendable {
        var formatter = Self()

        value.format(with: &formatter)

        return formatter.propertyList
    }

    // MARK: Private Instance Properties

    private var propertyList: [String: any Sendable]
}

// MARK: - Sendable

extension JSONFormatter: Sendable {
}

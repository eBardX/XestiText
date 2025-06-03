// © 2018–2025 John Gary Pusey (see LICENSE.md)

import Foundation

public final class JSONFormatter: KeyValueFormatter {

    // MARK: Public Initializers

    public init() {
        self.propertyList = [:]
    }

    // MARK: Public Instance Methods

    public func add(_ key: String,
                    _ value: Any) {
        switch value {
        case let values as [any KeyValueFormattable]:
            propertyList[key] = values.map { Self._convert($0) }

        case let value as any KeyValueFormattable:
            propertyList[key] = Self._convert(value)

        default:
            propertyList[key] = Self._convert(value)
        }
    }

    public func format() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: propertyList),
              let result = String(data: data,
                                  encoding: .utf8)
        else { return "" }

        return result
    }

    // MARK: Private Type Methods

    private static func _convert(_ value: Any?) -> Any {
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

    private static func _convert(_ value: some KeyValueFormattable) -> Any {
        let formatter = JSONFormatter()

        value.format(with: formatter)

        return formatter.propertyList
    }

    // MARK: Private Instance Properties

    private var propertyList: [String: Any]
}

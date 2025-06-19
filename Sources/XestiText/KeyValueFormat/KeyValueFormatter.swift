// © 2018–2025 John Gary Pusey (see LICENSE.md)

public protocol KeyValueFormatter {
    func add(_ key: String,
             _ value: Any)

    func addIfPresent(_ key: String,
                      _ value: Any?)

    func addSeparator()

    func format() -> String
}

extension KeyValueFormatter {
    public func addIfPresent(_ key: String,
                             _ value: Any?) {
        if let value {
            add(key, value)
        }
    }

    public func addSeparator() {
    }
}

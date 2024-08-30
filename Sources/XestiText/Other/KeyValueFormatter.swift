// © 2018–2024 John Gary Pusey (see LICENSE.md)

public protocol KeyValueFormatter {
    func add(_ key: String,
             _ value: Any)

    func addIfPresent(_ key: String,
                      _ value: Any?)

    func format() -> String
}

extension KeyValueFormatter {
    public func addIfPresent(_ key: String,
                             _ value: Any?) {
        guard let value = value
        else { return }

        add(key, value)
    }
}

// © 2018–2022 J. G. Pusey (see LICENSE.md)

public protocol KeyValueFormatter {
    func add(_ key: String,
             _ value: Any)

    func addIfPresent(_ key: String,
                      _ value: Any?)

    func format() -> String
}

public extension KeyValueFormatter {
    func addIfPresent(_ key: String,
                      _ value: Any?) {
        guard let value = value
        else { return }

        add(key, value)
    }
}

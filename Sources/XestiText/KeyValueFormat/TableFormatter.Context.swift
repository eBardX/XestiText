// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension TableFormatter {

    // MARK: Internal Nested Types

    internal struct Context: Sendable {

        // MARK: Internal Initializers

        internal init() {
            self.keys = []
            self.values = []
        }

        // MARK: Internal Instance Properties

        internal private(set) var keys: [String]
        internal private(set) var values: [String]
    }
}

// MARK: -

extension TableFormatter.Context {

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        keys.isEmpty && values.isEmpty
    }

    // MARK: Internal Instance Methods

    internal mutating func append(_ key: String,
                                  _ value: Any) {
        keys.append(key)
        values.append(String(describing: value))
    }
}

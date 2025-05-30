// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension TableFormatter {

    // MARK: Internal Nested Types

    internal struct Context: Sendable {

        // MARK: Internal Initializers

        internal init() {
            self.names = []
            self.values = []
        }

        // MARK: Internal Instance Properties

        internal private(set) var names: [String]
        internal private(set) var values: [String]
    }
}

// MARK: -

extension TableFormatter.Context {

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        names.isEmpty && values.isEmpty
    }

    // MARK: Internal Instance Methods

    internal mutating func append(_ name: String,
                                  _ value: Any) {
        names.append(name)
        values.append(String(describing: value))
    }
}

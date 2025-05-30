// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension TableFormatter {

    // MARK: Internal Nested Types

    internal struct Context: Sendable {

        // MARK: Internal Initializers

        internal init() {
            self.pairs = []
        }

        // MARK: Internal Instance Properties

        internal private(set) var pairs: [String]
    }
}

// MARK: -

extension TableFormatter.Context {

    // MARK: Internal Instance Properties

    internal var isEmpty: Bool {
        pairs.isEmpty
    }

    // MARK: Internal Instance Methods

    internal mutating func append(_ key: String?,
                                  _ value: Any?) {
        let ktext = if let key {
            Text(key, .left)
        } else {
            nil
        }

        let vtext = if let value {
            Text(String(describing: value), .left)
        } else {
            nil
        }

        pairs.append((ktext, vtext))
    }
}

// © 2018–2024 John Gary Pusey (see LICENSE.md)

import Foundation

extension Character {

    // MARK: Public Instance Properties

    public var isEmoji: Bool {
        switch self {
        case "💥",
            "👉":
            true

        default:
            false
        }
    }

    public var isNewline: Bool {
        guard let scalar = asSingleUnicodeScalar
        else { return false }

        return CharacterSet.newlines.contains(scalar)
    }

    public var isWhitespace: Bool {
        guard let scalar = asSingleUnicodeScalar
        else { return false }

        return CharacterSet.whitespaces.contains(scalar)
    }

    // MARK: Private Instance Properties

    private var asSingleUnicodeScalar: Unicode.Scalar? {
        String(self).unicodeScalars.first
    }
}

// © 2018 J. G. Pusey (see LICENSE.md)

import Foundation

public extension Character {

    // MARK: Public Instance Properties

    var isEmoji: Bool {
        switch self {
        case "💥",
             "👉":
            return true

        default:
            return false
        }
    }

    var isNewline: Bool {
        guard
            let scalar = asSingleUnicodeScalar
            else { return false }

        return CharacterSet.newlines.contains(scalar)
    }

    var isWhitespace: Bool {
        guard
            let scalar = asSingleUnicodeScalar
            else { return false }

        return CharacterSet.whitespaces.contains(scalar)
    }

    // MARK: Private Instance Properties

    private var asSingleUnicodeScalar: Unicode.Scalar? {
        let scalars = String(self).unicodeScalars

        return scalars.count == 1 ? scalars.first : nil
    }
}

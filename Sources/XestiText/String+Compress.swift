// © 2018–2022 J. G. Pusey (see LICENSE.md)

public extension String {

    // MARK: Public Type Properties

    static let defaultCompressPredicate: (Character) -> Bool = { $0.isWhitespace }

    // MARK: Public Instance Methods

    func compress(to char: Character = " ",
                  where predicate: (Character) -> Bool = defaultCompressPredicate) -> String {
        guard !isEmpty
        else { return self }

        var outChars: [Character] = []
        var inRun = true

        for inChar in self {
            let shouldCompress = predicate(inChar)

            if !shouldCompress {
                outChars.append(inChar)
                inRun = false
            } else if !inRun {
                outChars.append(char)
                inRun = true
            }
        }

        if inRun && !outChars.isEmpty {
            return String(outChars.dropLast())
        }

        return String(outChars)
    }
}

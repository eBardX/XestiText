// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Type Properties

    public static let defaultCompressionPredicate: @Sendable (Character) -> Bool = { $0.isWhitespace }

    // MARK: Public Instance Methods

    public func compressing(to char: Character = " ",
                            where predicate: @Sendable (Character) -> Bool = defaultCompressionPredicate) -> Self {
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
            return Self(outChars.dropLast())
        }

        return Self(outChars)
    }
}

// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Type Properties

    public static let defaultCompressionPredicate: @Sendable (Character) -> Bool = { $0.isWhitespace }

    // MARK: Public Instance Methods

    public func compressing(to char: Character = " ",
                            where predicate: (Character) -> Bool = defaultCompressionPredicate) -> String {
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

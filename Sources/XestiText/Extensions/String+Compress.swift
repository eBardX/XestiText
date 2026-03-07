// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Type Properties

    /// The default compression predicate for ``compressing(to:where:)``.
    ///
    /// This predicate tests for whitespace characters as defined by
    /// `Character.isWhitespace`.
    public static let defaultCompressionPredicate: @Sendable (Character) -> Bool = { $0.isWhitespace }

    // MARK: Public Instance Methods

    /// Returns a new string created by trimming all leading and trailing
    /// characters satisfying the provided predicate and then replacing all runs
    /// of characters satisfying the predicate by a _single_, given character.
    ///
    /// By default, you can use this method to trim and compress all whitespace,
    /// including newlines:
    ///
    /// ```swift
    /// print("\tHello,   world!\r\n".compressing())
    /// // Prints "Hello, world!"
    /// ```
    ///
    /// You can also use it to perform a more customized action:
    ///
    /// ```swift
    /// print("Thi$ i$$ a te$$$t".compressing(to: "s") { $0 == "$" })
    /// // Prints "This is a test"
    /// ```
    ///
    /// - Parameter char:       The replacement character. Defaults to the space
    ///                         character.
    /// - Parameter predicate:  A closure that takes a character of this string
    ///                         as its argument and returns `true` if the
    ///                         character should be trimmed or replaced.
    ///                         Defaults to ``defaultCompressionPredicate``.
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

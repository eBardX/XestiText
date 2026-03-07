// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    /// Splits this string into an array of string elements such that each
    /// element is either a concatenation of space-separated words that do not
    /// exceed the specified width, or a single word.
    ///
    /// For example, you can use this method to wrap a string to fit into a
    /// particular width for display purposes:
    ///
    /// ```swift
    /// let text = "This is a test. This is only a test. If this had been a non-hypothetical emergency, you would be sorry!"
    /// print(text.wrapping(at: 10))
    /// // Prints []
    /// ```
    ///
    /// If `splitWords` is `true`, any single word that exceeds the specified
    /// width is split into multiple parts. In such case, the final word part
    /// may be concatenated to a subsequent word or word part. Using the same
    /// text as in the preceding example:
    ///
    /// ```swift
    /// print(text.wrapping(at: 10,
    ///                     splitWords: true))
    /// // Prints []
    /// ```
    ///
    /// - Parameter width:      The width to wrap this string to fit.
    /// - Parameter splitWords: A Boolean value indicating whether words that
    ///                         exceed `width` should be split. The default is
    ///                         `false`.
    ///
    /// - Returns:  The array of wrapped strings.
    public func wrapping(at width: Int,
                         splitWords: Bool = false) -> [Self] {
        guard count > width
        else { return [self] }

        let words = _splitIntoWords(width, splitWords)

        return _arrangeWords(words, width)
    }

    // MARK: Private Instance Methods

    private func _splitIntoWords(_ width: Int,
                                 _ splitWords: Bool) -> [Self] {
        split { $0.isWhitespace }
            .filter { !$0.isEmpty }
            .map(Self.init)
            .flatMap { word in
                if splitWords, word.count > width {
                    _splitWord(word, width)
                } else {
                    [word]
                }
            }
    }
}

// MARK: - Private Functions

private func _arrangeWords(_ words: [String],
                           _ width: Int) -> [String] {
    var segments: [String] = []
    var segment = ""

    for word in words {
        if segment.isEmpty {
            segment = word
        } else if (segment.count + 1 + word.count) > width {
            segments.append(segment)

            segment = word
        } else {
            segment.append(" ")
            segment.append(word)
        }
    }

    if !segment.isEmpty {
        segments.append(segment)
    }

    return segments
}

private func _splitWord(_ word: String,
                        _ width: Int) -> [String] {
    var fragments: [String] = []
    var fragment = word

    while fragment.count > width {
        fragments.append(String(fragment.prefix(width)))

        fragment = String(fragment.dropFirst(width))
    }

    if !fragment.isEmpty {
        fragments.append(fragment)
    }

    return fragments
}

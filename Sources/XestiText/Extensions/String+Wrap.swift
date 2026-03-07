// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

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

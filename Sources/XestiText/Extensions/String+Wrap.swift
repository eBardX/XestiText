// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func wrapping(at width: Int,
                         splitWords: Bool = false) -> [Self] {
        guard count > width
        else { return [self] }

        let words = _splitIntoWords()

        if splitWords {
            return _arrangeSplitWords(words, width)
        }

        return _arrangeWords(words, width)
    }

    // MARK: Private Instance Methods

    private func _arrangeWords(_ words: [Self],
                               _ width: Int) -> [Self] {
        var segments: [Self] = []
        var segment = ""

        for word in words {
            if segment.isEmpty {
                segment = word
            } else if segment.count + 1 + word.count > width {
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

    private func _arrangeSplitWords(_ words: [Self],
                                    _ width: Int) -> [Self] {
        var segments: [Self] = []
        var segment = ""

        for word in words {
            if word.count > width {
                if !segment.isEmpty {
                    segments.append(segment)

                    segment = ""
                }

                for char in word {
                    if segment.count + 1 > width {
                        segments.append(segment)

                        segment = Self(char)
                    } else {
                        segment.append(char)
                    }
                }
            } else if segment.count + 1 + 1 > width {
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

    private func _splitIntoWords() -> [Self] {
        self.split { $0.isNewline || $0.isWhitespace }
            .filter { !$0.isEmpty }
            .map(Self.init)
    }
}

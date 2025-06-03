// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func wrapping(at width: Int,
                         splitWords: Bool = false) -> [String] {
        guard count > width
        else { return [self] }

        let words = _splitIntoWords()

        if splitWords {
            return _arrangeSplitWords(words, width)
        }

        return _arrangeWords(words, width)
    }

    // MARK: Private Instance Methods

    private func _arrangeWords(_ words: [String],
                               _ width: Int) -> [String] {
        var segments: [String] = []
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

    private func _arrangeSplitWords(_ words: [String],
                                    _ width: Int) -> [String] {
        var segments: [String] = []
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

                        segment = String(char)
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

    private func _splitIntoWords() -> [String] {
        self.split { $0.isNewline || $0.isWhitespace }
            .filter { !$0.isEmpty }
            .map(String.init)
    }
}

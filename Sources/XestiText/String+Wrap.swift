// © 2018 J. G. Pusey (see LICENSE.md)

public extension String {

    // MARK: Public Instance Methods

    func wrap(_ width: Int,
              splitWords: Bool = false) -> [String] {
        guard
            count > width
            else { return [self] }

        let words = splitIntoWords()

        return splitWords
            ? arrangeSplitWords(words, width)
            : arrangeWords(words, width)
    }

    // MARK: Private Instance Methods

    private func arrangeWords(_ words: [String],
                              _ width: Int) -> [String] {
        var segments: [String] = []
        var segment = ""

        for word in words {
            if segment.isEmpty {
                segment = word
            } else if segment.displayWidth + 1 + word.displayWidth > width {
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

    private func arrangeSplitWords(_ words: [String],
                                   _ width: Int) -> [String] {
        var segments: [String] = []
        var segment = ""

        for word in words {
            if word.displayWidth > width {
                if !segment.isEmpty {
                    segments.append(segment)

                    segment = ""
                }

                for char in word {
                    if segment.displayWidth + char.displayWidth > width {
                        segments.append(segment)

                        segment = String(char)
                    } else {
                        segment.append(char)
                    }
                }
            } else if segment.displayWidth + 1 + word.displayWidth > width {
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

    private func splitIntoWords() -> [String] {
        return self
            .split { $0.isNewline || $0.isWhitespace }
            .filter { !$0.isEmpty }
            .map(String.init)
    }
}

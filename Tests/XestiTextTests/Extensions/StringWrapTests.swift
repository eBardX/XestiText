// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringWrapTests {
}

// MARK: -

extension StringWrapTests {
    @Test
    func test_wrapping() {
        let text = """
            This is a test.
            This is only a test.
            If this had been a non-hypothetical emergency, you would be sorry!
            """

        #expect(text.wrapping(at: 10) == ["This is a",
                                          "test. This",
                                          "is only a",
                                          "test. If",
                                          "this had",
                                          "been a",
                                          "non-hypothetical",
                                          "emergency,",
                                          "you would",
                                          "be sorry!"])

        #expect(text.wrapping(at: 10,
                              splitWords: true) == ["This is a",
                                                    "test. This",
                                                    "is only a",
                                                    "test. If",
                                                    "this had",
                                                    "been a",
                                                    "non-hypoth",
                                                    "etical",
                                                    "emergency,",
                                                    "you would",
                                                    "be sorry!"])
    }

    @Test
    func test_wrapping_emptyString() {
        #expect("".wrapping(at: 10) == [""])
    }

    @Test
    func test_wrapping_negativeWidth() {
        #expect("Hello".wrapping(at: -1) == ["Hello"])
    }

    @Test
    func test_wrapping_stringFitsInWidth() {
        #expect("Hello".wrapping(at: 10) == ["Hello"])
    }

    @Test
    func test_wrapping_widthOne() {
        #expect("ab cd".wrapping(at: 1) == ["ab", "cd"])
        #expect("ab cd".wrapping(at: 1,
                                 splitWords: true) == ["a", "b", "c", "d"])
    }

    @Test
    func test_wrapping_widthZero() {
        #expect("Hello".wrapping(at: 0) == ["Hello"])
    }

    @Test
    func test_wrapping_wordLongerThanWidth_noSplit() {
        #expect("Supercalifragilistic".wrapping(at: 5) == ["Supercalifragilistic"])
    }

    @Test
    func test_wrapping_wordLongerThanWidth_withSplit() {
        #expect("Supercalifragilistic".wrapping(at: 5,
                                                splitWords: true) == ["Super",
                                                                      "calif",
                                                                      "ragil",
                                                                      "istic"])
    }
}

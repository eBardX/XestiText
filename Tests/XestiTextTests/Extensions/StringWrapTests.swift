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
}

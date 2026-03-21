// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringFitTests {
}

// MARK: -

extension StringFitTests {
    @Test
    func test_fitting() {
        #expect("Hello, world!".fitting(to: 10,
                                        alignment: .center,
                                        usingEllipses: false) == "Hello, wor")
        #expect("Hello, world!".fitting(to: 20,
                                        alignment: .center,
                                        usingEllipses: false) == "   Hello, world!    ")
    }

    @Test
    func test_fitting_exactWidth() {
        #expect("Hello".fitting(to: 5) == "Hello")
        #expect("Hello".fitting(to: 5,
                                alignment: .center,
                                usingEllipses: false) == "Hello")
    }

    @Test
    func test_fitting_leftAlignment() {
        #expect("Hello".fitting(to: 10,
                                alignment: .left,
                                usingEllipses: false) == "Hello     ")
        #expect("Hello, world!".fitting(to: 5,
                                        alignment: .left,
                                        usingEllipses: false) == "Hello")
    }

    @Test
    func test_fitting_negativeWidth() {
        #expect("Hello".fitting(to: -1).isEmpty)
    }

    @Test
    func test_fitting_rightAlignment() {
        #expect("Hello".fitting(to: 10,
                                alignment: .right,
                                usingEllipses: false) == "     Hello")
        #expect("Hello, world!".fitting(to: 5,
                                        alignment: .right,
                                        usingEllipses: false) == "Hello")
    }

    @Test
    func test_fitting_usingEllipses() {
        #expect("Hello, world!".fitting(to: 10) == "Hello, wo…")
        #expect("Hello, world!".fitting(to: 5) == "Hell…")
    }

    @Test
    func test_fitting_widthZero() {
        #expect("Hello".fitting(to: 0).isEmpty)
    }
}

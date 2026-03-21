// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct StringBoxTests {
}

// MARK: -

extension StringBoxTests {
    @Test
    func test_double_box() {
        let box = String.Box.double

        #expect(box.bottomLeftJoiner == "╚")
        #expect(box.bottomRightJoiner == "╝")
        #expect(box.horizontalPipe == "═")
        #expect(box.topLeftJoiner == "╔")
        #expect(box.topRightJoiner == "╗")
        #expect(box.verticalPipe == "║")
    }

    @Test
    func test_heavy_box() {
        let box = String.Box.heavy

        #expect(box.bottomLeftJoiner == "┗")
        #expect(box.bottomRightJoiner == "┛")
        #expect(box.horizontalPipe == "━")
        #expect(box.topLeftJoiner == "┏")
        #expect(box.topRightJoiner == "┓")
        #expect(box.verticalPipe == "┃")
    }

    @Test
    func test_light_box() {
        let box = String.Box.light

        #expect(box.bottomLeftJoiner == "└")
        #expect(box.bottomRightJoiner == "┘")
        #expect(box.horizontalPipe == "─")
        #expect(box.topLeftJoiner == "┌")
        #expect(box.topRightJoiner == "┐")
        #expect(box.verticalPipe == "│")
    }

    @Test
    func test_plain_box() {
        let box = String.Box.plain

        #expect(box.bottomCenterJoiner == "+")
        #expect(box.bottomLeftJoiner == "+")
        #expect(box.bottomRightJoiner == "+")
        #expect(box.horizontalPipe == "-")
        #expect(box.middleCenterJoiner == "+")
        #expect(box.middleLeftJoiner == "+")
        #expect(box.middleRightJoiner == "+")
        #expect(box.topCenterJoiner == "+")
        #expect(box.topLeftJoiner == "+")
        #expect(box.topRightJoiner == "+")
        #expect(box.verticalPipe == "|")
    }
}

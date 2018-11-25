//
//  Table.Box.swift
//  XestiText
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

public extension Table {

    // MARK: Public Nested Types

    struct Box {

        // MARK: Public Instance Properties

        public var h: Character
        public var v: Character
        public var dr: Character
        public var dl: Character
        public var ur: Character
        public var ul: Character
        public var vr: Character
        public var vl: Character
        public var dh: Character
        public var uh: Character
        public var vh: Character
    }
}

public extension Table.Box {

    // MARK: Public Type Properties

    static let double = Table.Box(h: "═",
                                  v: "║",
                                  dr: "╔",
                                  dl: "╗",
                                  ur: "╚",
                                  ul: "╝",
                                  vr: "╠",
                                  vl: "╣",
                                  dh: "╦",
                                  uh: "╩",
                                  vh: "╬")
    static let heavy = Table.Box(h: "━",
                                 v: "┃",
                                 dr: "┏",
                                 dl: "┓",
                                 ur: "┗",
                                 ul: "┛",
                                 vr: "┣",
                                 vl: "┫",
                                 dh: "┳",
                                 uh: "┻",
                                 vh: "╋")
    static let light = Table.Box(h: "─",
                                 v: "│",
                                 dr: "┌",
                                 dl: "┐",
                                 ur: "└",
                                 ul: "┘",
                                 vr: "├",
                                 vl: "┤",
                                 dh: "┬",
                                 uh: "┴",
                                 vh: "┼")
    static let plain = Table.Box(h: "-",
                                 v: "|",
                                 dr: "+",
                                 dl: "+",
                                 ur: "+",
                                 ul: "+",
                                 vr: "+",
                                 vl: "+",
                                 dh: "+",
                                 uh: "+",
                                 vh: "+")
}

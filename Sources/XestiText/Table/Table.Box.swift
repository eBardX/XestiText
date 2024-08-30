// © 2018–2024 John Gary Pusey (see LICENSE.md)

extension Table {

    // MARK: Public Nested Types

    public struct Box {

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

extension Table.Box {

    // MARK: Public Type Properties

    public static let double = Table.Box(h: "═",
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
    public static let heavy = Table.Box(h: "━",
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
    public static let light = Table.Box(h: "─",
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
    public static let plain = Table.Box(h: "-",
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

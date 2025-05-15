// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Nested Types

    public struct Box: Sendable {

        // MARK: Public Instance Properties

        public var horizontalPipe: Character
        public var verticalPipe: Character
        public var topLeftJoiner: Character
        public var topCenterJoiner: Character
        public var topRightJoiner: Character
        public var middleLeftJoiner: Character
        public var middleCenterJoiner: Character
        public var middleRightJoiner: Character
        public var bottomLeftJoiner: Character
        public var bottomCenterJoiner: Character
        public var bottomRightJoiner: Character
    }
}

extension String.Box {

    // MARK: Public Type Properties

    public static let double = Self(horizontalPipe: "═",
                                    verticalPipe: "║",
                                    topLeftJoiner: "╔",
                                    topCenterJoiner: "╦",
                                    topRightJoiner: "╗",
                                    middleLeftJoiner: "╠",
                                    middleCenterJoiner: "╬",
                                    middleRightJoiner: "╣",
                                    bottomLeftJoiner: "╚",
                                    bottomCenterJoiner: "╩",
                                    bottomRightJoiner: "╝")
    public static let heavy = Self(horizontalPipe: "━",
                                   verticalPipe: "┃",
                                   topLeftJoiner: "┏",
                                   topCenterJoiner: "┳",
                                   topRightJoiner: "┓",
                                   middleLeftJoiner: "┣",
                                   middleCenterJoiner: "╋",
                                   middleRightJoiner: "┫",
                                   bottomLeftJoiner: "┗",
                                   bottomCenterJoiner: "┻",
                                   bottomRightJoiner: "┛")
    public static let light = Self(horizontalPipe: "─",
                                   verticalPipe: "│",
                                   topLeftJoiner: "┌",
                                   topCenterJoiner: "┬",
                                   topRightJoiner: "┐",
                                   middleLeftJoiner: "├",
                                   middleCenterJoiner: "┼",
                                   middleRightJoiner: "┤",
                                   bottomLeftJoiner: "└",
                                   bottomCenterJoiner: "┴",
                                   bottomRightJoiner: "┘")
    public static let plain = Self(horizontalPipe: "-",
                                   verticalPipe: "|",
                                   topLeftJoiner: "+",
                                   topCenterJoiner: "+",
                                   topRightJoiner: "+",
                                   middleLeftJoiner: "+",
                                   middleCenterJoiner: "+",
                                   middleRightJoiner: "+",
                                   bottomLeftJoiner: "+",
                                   bottomCenterJoiner: "+",
                                   bottomRightJoiner: "+")
}

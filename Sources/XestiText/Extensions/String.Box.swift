// © 2018–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Nested Types

    public struct Box {

        // MARK: Public Instance Properties

        public let horizontalPipe: Character
        public let verticalPipe: Character
        public let topLeftJoiner: Character
        public let topCenterJoiner: Character
        public let topRightJoiner: Character
        public let middleLeftJoiner: Character
        public let middleCenterJoiner: Character
        public let middleRightJoiner: Character
        public let bottomLeftJoiner: Character
        public let bottomCenterJoiner: Character
        public let bottomRightJoiner: Character
    }
}

// MARK: -

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

// MARK: - Sendable

extension String.Box: Sendable {
}

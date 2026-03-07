// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Nested Types

    /// An encapsulation of box-drawing characters to facilitate drawing frames
    /// and boxes with monospaced fonts.
    ///
    /// For example, defining the following simple function:
    ///
    /// ```swift
    /// func print2x2(_ box: String.Box) {
    ///     var output = ""
    ///
    ///     output += String([box.topLeftJoiner,    box.horizontalPipe, box.topCenterJoiner,    box.horizontalPipe, box.topRightJoiner,    "\n"])
    ///     output += String([box.verticalPipe,     " ",                box.verticalPipe,       " ",                box.verticalPipe,      "\n"])
    ///     output += String([box.middleLeftJoiner, box.horizontalPipe, box.middleCenterJoiner, box.horizontalPipe, box.middleRightJoiner, "\n"])
    ///     output += String([box.verticalPipe,     " ",                box.verticalPipe,       " ",                box.verticalPipe,      "\n"])
    ///     output += String([box.bottomLeftJoiner, box.horizontalPipe, box.bottomCenterJoiner, box.horizontalPipe, box.bottomRightJoiner, "\n"])
    ///
    ///     print(output)
    /// }
    /// ```
    ///
    /// Allows you to easily display the _same_ figure using _different_
    /// box-drawing characters:
    ///
    /// ```swift
    /// print2x2(.light)    // ┌─┬─┐
    ///                     // │ │ │
    ///                     // ├─┼─┤
    ///                     // │ │ │
    ///                     // └─┴─┘
    ///
    /// print2x2(.heavy)    // ┏━┳━┓
    ///                     // ┃ ┃ ┃
    ///                     // ┣━╋━┫
    ///                     // ┃ ┃ ┃
    ///                     // ┗━┻━┛
    ///
    /// print2x2(.double)   // ╔═╦═╗
    ///                     // ║ ║ ║
    ///                     // ╠═╬═╣
    ///                     // ║ ║ ║
    ///                     // ╚═╩═╝
    ///
    /// print2x2(.plain)    // +-+-+
    ///                     // | | |
    ///                     // +-+-+
    ///                     // | | |
    ///                     // +-+-+
    /// ```
    public struct Box {

        // MARK: Public Instance Properties

        /// The horizontal pipe character. For example, “`━`”.
        public let horizontalPipe: Character

        /// The vertical pipe character. For example, “`┃`”.
        public let verticalPipe: Character

        /// The top-left joiner character. For example, “`┏`”.
        public let topLeftJoiner: Character

        /// The top-center joiner character. For example, “`┳`”.
        public let topCenterJoiner: Character

        /// The top-right joiner character. For example, “`┓`”.
        public let topRightJoiner: Character

        /// The middle-left joiner character . For example, “`┣`”.
        public let middleLeftJoiner: Character

        /// The middle-center joiner character. For example, “`╋`”.
        public let middleCenterJoiner: Character

        /// The middle-right joiner character. For example, “`┫`”.
        public let middleRightJoiner: Character

        /// The bottom-left joiner character. For example, “`┗`”.
        public let bottomLeftJoiner: Character

        /// The bottom-center joiner character. For example, “`┻`”.
        public let bottomCenterJoiner: Character

        /// The bottom-right joiner character. For example, “`┛`”.
        public let bottomRightJoiner: Character
    }
}

// MARK: -

extension String.Box {

    // MARK: Public Type Properties

    /// Doubly-stroked box characters.
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

    /// Heavily-stroked box characters.
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

    /// Lightly-stroked box characters.
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

    /// Plain ASCII box characters. (For when you need to go “old school”.)
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

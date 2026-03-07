// © 2024–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    /// Returns a new string created by padding this string to the specified
    /// width.
    ///
    /// For example, you can use this method to pad a string to fit into a
    /// particular width for display purposes:
    ///
    /// ```swift
    /// print("Hello, world!".padding(to: 20))
    /// // Prints "Hello, world!       "
    ///
    /// print("Hello, world!".padding(to: 20,
    ///                               alignment: .right))
    /// // Prints "       Hello, world!"
    ///
    /// print("Hello, world!".padding(to: 20,
    ///                               alignment: .center))
    /// // Prints "   Hello, world!    "
    /// ```
    ///
    /// If the number of characters in this string is greater than the specified
    /// width, the string itself is returned.
    ///
    /// - Parameter width:      The width to pad this string to fit.
    /// - Parameter alignment:  The alignment of this string in the resulting
    ///                         string. Defaults to `.left`.
    ///
    /// - Returns:  The padded string.
    public func padding(to width: Int,
                        alignment: Alignment = .left) -> Self {
        guard width > 0
        else { return "" }

        guard width > count
        else { return self }

        let padWidth = width - count

        switch alignment {
        case .center:
            let padWidthL = padWidth / 2
            let padWidthR = padWidth - padWidthL

            return " ".repeating(to: padWidthL) + self + " ".repeating(to: padWidthR)

        case .left:
            return self + " ".repeating(to: padWidth)

        case .right:
            return " ".repeating(to: padWidth) + self
        }
    }
}

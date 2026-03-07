// © 2024–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    /// Returns a new string created by truncating this string to the specified
    /// width.
    ///
    /// For example, you can use this method to truncate a string to fit into a
    /// particular width for display purposes:
    ///
    /// ```swift
    /// print("Hello, world!".truncating(at: 9))
    /// // Prints "Hello, w…"
    /// ```
    ///
    /// If `usingEllipses` is `false`, the final character of the truncated
    /// string is not replaced with an ellipsis character:
    ///
    /// ```swift
    /// print("Hello, world!".truncating(at: 9,
    ///                                  usingEllipses: false)
    /// // Prints "Hello, wo"
    /// ```
    ///
    /// If the number of characters in this string is less than the specified
    /// width, the string itself is returned.
    ///
    /// - Parameter width:          The width to truncate this string to fit.
    /// - Parameter usingEllipses:  A Boolean value indicating whether the final
    ///                             character of the truncated string should be
    ///                             replaced with an ellipsis character. The
    ///                             default is `true`.
    ///
    /// - Returns:  The truncated string.
    public func truncating(at width: Int,
                           usingEllipses: Bool = true) -> Self {
        guard width > 0
        else { return "" }

        guard width < count
        else { return self }

        let truncIndex = index(startIndex,
                               offsetBy: usingEllipses ? width - 1 : width)

        let result = Self(self[startIndex..<truncIndex])

        return usingEllipses ? result + "…" : result
    }
}

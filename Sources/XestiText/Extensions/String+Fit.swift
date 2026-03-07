// © 2024–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    /// Returns a new string created by either truncating or padding this string
    /// to the specified width.
    ///
    /// For example, you can use this method to fit a string to a particular
    /// width for display purposes:
    ///
    /// ```swift
    /// print("Hello, world!".fitting(to: 10,
    ///                               alignment: .center,
    ///                               usingEllipses: false)
    /// // Prints "Hello, wor"
    ///
    /// print("Hello, world!".fitting(to: 20,
    ///                               alignment: .center,
    ///                               usingEllipses: false)
    /// // Prints "   Hello, world!    "
    /// ```
    ///
    /// If the number of characters in this string is exactly to the specified
    /// width, the string itself is returned.
    ///
    /// - Parameter width:          The width to truncate or pad this string to
    ///                             fit.
    /// - Parameter alignment:      The alignment of this string in the
    ///                             resulting string if padded to fit. Defaults
    ///                             to `.left`.
    /// - Parameter usingEllipses:  A Boolean value indicating whether the final
    ///                             character of the truncated string should be
    ///                             replaced with an ellipsis character. The
    ///                             default is `true`.
    ///
    /// - Returns:  The fitted string.
    public func fitting(to width: Int,
                        alignment: Alignment = .left,
                        usingEllipses: Bool = true) -> Self {
        if width < count {
            truncating(at: width,
                       usingEllipses: usingEllipses)
        } else if width > count {
            padding(to: width,
                    alignment: alignment)
        } else {
            self
        }
    }
}

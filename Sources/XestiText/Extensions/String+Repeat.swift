// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    /// Returns a new string created by repeating this string the specified
    /// number of times.
    ///
    /// For example, you can use this method to make a string with seven `"xyz"`
    /// strings in a row:
    ///
    /// ```swift
    /// print("xyz".repeating(to: 7))
    /// // Prints "xyzxyzxyzxyzxyzxyzxyz"
    /// ```
    ///
    /// - Parameter count:  The number of times to repeat this string.
    ///
    /// - Returns:  The repeated string.
    public func repeating(to count: Int) -> Self {
        Self(repeating: self,
             count: count)
    }
}

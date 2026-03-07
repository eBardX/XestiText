// © 2018–2026 John Gary Pusey (see LICENSE.md)

/// A type that can format itself with a key-value formatter.
public protocol KeyValueFormattable {
    /// Formats this instance with the provided key-value formatter.
    ///
    /// - Parameter formatter:  The key-value formatter with which to format
    ///                         this instance.
    func format(with formatter: inout some KeyValueFormatter)
}

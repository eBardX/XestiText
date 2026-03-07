// © 2018–2026 John Gary Pusey (see LICENSE.md)

import CoreGraphics

/// A namespace for type properties and methods related to terminal type
/// devices.
public enum Terminal {

    // MARK: Public Type Properties

    /// A Boolean value indicating whether standard output is associated with a
    /// valid terminal type device.
    public static var isTerminal: Bool {
        isatty(STDOUT_FILENO) != 0
    }

    // MARK: Public Type Methods

    /// Determines the window size of the terminal type device associated with
    /// standard output.
    ///
    /// The window size is encapsulated by an instance of `CGSize`, where
    /// `width` represents the number of columns, and `height` represents the
    /// number of rows. Width and height are measured in (fixed-width)
    /// characters.
    ///
    /// If standard output is not associated with a valid terminal type device,
    /// this method returns `nil`.
    ///
    /// - Returns:  The window size of the terminal type device.
    public static func size() -> CGSize? {
        var wsize = winsize()

        guard ioctl(STDOUT_FILENO, TIOCGWINSZ, &wsize) == 0
        else { return nil }

        return CGSize(width: CGFloat(wsize.ws_col),
                      height: CGFloat(wsize.ws_row))
    }
}

// © 2018–2024 John Gary Pusey (see LICENSE.md)

import CoreGraphics

public enum Terminal {

    // MARK: Public Type Properties

    public static var isTerminal: Bool {
        isatty(STDOUT_FILENO) != 0
    }

    // MARK: Public Type Methods

    public static func size() -> CGSize? {
        var wsize = winsize()

        guard ioctl(STDOUT_FILENO, TIOCGWINSZ, &wsize) == 0
        else { return nil }

        return CGSize(width: CGFloat(wsize.ws_col),
                      height: CGFloat(wsize.ws_row))
    }
}

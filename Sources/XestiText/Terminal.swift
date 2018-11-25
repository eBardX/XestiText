//
//  Terminal.swift
//  XestiText
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

import CoreGraphics
import Darwin

public enum Terminal {

    // MARK: Public Type Properties

    public static var isTerminal: Bool {
        return isatty(STDOUT_FILENO) != 0
    }

    // MARK: Public Type Methods

    public static func size() -> CGSize? {
        var wsize = winsize()

        guard
            ioctl(STDOUT_FILENO, TIOCGWINSZ, &wsize) == 0
            else { return nil }

        return CGSize(width: CGFloat(wsize.ws_col),
                      height: CGFloat(wsize.ws_row))
    }
}

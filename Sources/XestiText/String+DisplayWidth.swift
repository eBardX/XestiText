//
//  String+DisplayWidth.swift
//  XestiText
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

public extension String {

    // MARK: Public Instance Properties

    var displayWidth: Int {
        return reduce(0) { $0 + $1.displayWidth }
    }
}

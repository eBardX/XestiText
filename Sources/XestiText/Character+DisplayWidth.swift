//
//  Character+DisplayWidth.swift
//  XestiText
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

public extension Character {

    // MARK: Public Instance Properties

    var displayWidth: Int {
        return isEmoji ? 2 : 1
    }
}

// © 2018–2022 J. G. Pusey (see LICENSE.md)

public extension Character {

    // MARK: Public Instance Properties

    var displayWidth: Int {
        isEmoji ? 2 : 1
    }
}

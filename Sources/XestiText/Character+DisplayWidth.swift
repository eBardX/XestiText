// © 2018 J. G. Pusey (see LICENSE.md)

public extension Character {

    // MARK: Public Instance Properties

    var displayWidth: Int {
        return isEmoji ? 2 : 1
    }
}

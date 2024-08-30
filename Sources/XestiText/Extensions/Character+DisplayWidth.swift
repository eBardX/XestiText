// © 2018–2024 John Gary Pusey (see LICENSE.md)

extension Character {

    // MARK: Public Instance Properties

    public var displayWidth: Int {
        isEmoji ? 2 : 1
    }
}

// © 2018–2022 J. G. Pusey (see LICENSE.md)

public extension String {

    // MARK: Public Instance Properties

    var displayWidth: Int {
        reduce(0) { $0 + $1.displayWidth }
    }
}

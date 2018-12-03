// © 2018 J. G. Pusey (see LICENSE.md)

public extension String {

    // MARK: Public Instance Properties

    var displayWidth: Int {
        return reduce(0) { $0 + $1.displayWidth }
    }
}

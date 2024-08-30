// © 2018–2024 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Properties

    public var displayWidth: Int {
        reduce(0) { $0 + $1.displayWidth }
    }
}

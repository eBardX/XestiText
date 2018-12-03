// © 2018 J. G. Pusey (see LICENSE.md)

public extension String {

    // MARK: Public Instance Methods

    func `repeat`(_ count: Int) -> String {
        return String(repeating: self,
                      count: count)
    }
}

// © 2018–2022 J. G. Pusey (see LICENSE.md)

public extension String {

    // MARK: Public Instance Methods

    func `repeat`(_ count: Int) -> String {
        String(repeating: self,
               count: count)
    }
}

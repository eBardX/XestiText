// © 2018–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func repeating(to count: Int) -> Self {
        Self(repeating: self,
             count: count)
    }
}

// © 2018–2024 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func repeating(to count: Int) -> String {
        .init(repeating: self,
              count: count)
    }
}

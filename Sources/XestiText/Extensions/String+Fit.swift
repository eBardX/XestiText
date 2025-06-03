// © 2024–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func fitting(to width: Int,
                        alignment: Alignment = .left,
                        usingEllipses: Bool = true) -> String {
        if width < count {
            truncating(at: width,
                       usingEllipses: usingEllipses)
        } else if width > count {
            padding(to: width,
                    alignment: alignment)
        } else {
            self
        }
    }
}

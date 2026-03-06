// © 2024–2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func fitting(to width: Int,
                        alignment: Alignment = .left,
                        usingEllipses: Bool = true) -> Self {
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

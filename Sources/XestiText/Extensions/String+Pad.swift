// © 2024–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func padding(to width: Int,
                        alignment: Alignment = .left) -> String {
        guard width > 0
        else { return "" }

        guard width > count
        else { return self }

        let padWidth = width - count

        switch alignment {
        case .center:
            let padWidthL = padWidth / 2
            let padWidthR = padWidth - padWidthL

            return " ".repeating(to: padWidthL) + self + " ".repeating(to: padWidthR)

        case .left:
            return self + " ".repeating(to: padWidth)

        case .right:
            return " ".repeating(to: padWidth) + self
        }
    }
}

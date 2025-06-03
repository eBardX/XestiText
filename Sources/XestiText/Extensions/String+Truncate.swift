// © 2024–2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Public Instance Methods

    public func truncating(at width: Int,
                           usingEllipses: Bool = true) -> String {
        guard width > 0
        else { return "" }

        guard width < count
        else { return self }

        let truncIndex = index(startIndex,
                               offsetBy: usingEllipses ? width - 1 : width)

        let result = String(self[startIndex..<truncIndex])

        return usingEllipses ? result + "…" : result
    }
}

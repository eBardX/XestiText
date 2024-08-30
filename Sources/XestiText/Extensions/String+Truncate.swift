// © 2024 John Gary Pusey (see LICENSE.md)

extension String {
    public func truncating(at width: Int,
                           usingEllipses: Bool = true) -> String {
        guard width > 0
        else { return "" }

        guard width < count
        else { return self }

        guard width > 1
        else { return "…"}

        let truncIndex = index(startIndex,
                               offsetBy: width - 1)

        return self[startIndex..<truncIndex] + "…"
    }
}

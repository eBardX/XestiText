// © 2018–2025 John Gary Pusey (see LICENSE.md)

public struct Table {

    // MARK: Public Initializers

    public init(header: String? = nil,
                columns: [Column] = [],
                footer: String? = nil,
                minimumWidth: Int? = nil,
                maximumWidth: Int? = nil) {
        self.columns = columns
        self.footer = footer
        self.header = header
        self.maximumWidth = maximumWidth
        self.minimumWidth = minimumWidth
    }

    // MARK: Public Instance Properties

    public var columns: [Column]
    public var footer: String?
    public var header: String?
    public var maximumWidth: Int?
    public var minimumWidth: Int?

    public var isEmpty: Bool {
        columns.isEmpty || columns.allSatisfy { $0.isEmpty }
    }

    // MARK: Public Instance Methods

    public func render(box: Self.Box = .plain) -> String {
        TableRenderer(self).render(box: box)
    }
}

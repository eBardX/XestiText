// © 2018 J. G. Pusey (see LICENSE.md)

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

    // MARK: Public Instance Methods

    public func render() -> String {
        return TableRenderer(self).render()
    }
}

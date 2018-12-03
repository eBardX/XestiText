// © 2018 J. G. Pusey (see LICENSE.md)

public extension Table {

    // MARK: Public Instance Methods

    mutating func append(_ name: String,
                         _ value: Any) {
        var tmpColumns = columns

        if tmpColumns.isEmpty {
            tmpColumns = [Column(), Column()]
        } else if tmpColumns.count != 2 {
            fatalError("Bad table!")
        }

        var nameColumn = tmpColumns[0]
        var valueColumn = tmpColumns[1]

        var names = nameColumn.values
        var values = valueColumn.values

        if names.count != values.count {
            fatalError("Bad table!")
        }

        names.append(name)
        values.append(String(describing: value))

        nameColumn.values = names
        valueColumn.values = values

        columns = [nameColumn, valueColumn]
    }

    mutating func appendIfPresent(_ name: String,
                                  _ value: Any?) {
        guard
            let value = value
            else { return }

        append(name, value)
    }
}

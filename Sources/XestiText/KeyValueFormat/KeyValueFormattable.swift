// © 2018–2026 John Gary Pusey (see LICENSE.md)

public protocol KeyValueFormattable {
    func format(with formatter: inout some KeyValueFormatter)
}

// © 2018–2023 J. G. Pusey (see LICENSE.md)

public protocol KeyValueFormattable {
    func format(with formatter: some KeyValueFormatter)
}

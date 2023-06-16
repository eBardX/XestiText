// © 2018–2022 J. G. Pusey (see LICENSE.md)

public protocol KeyValueFormattable {
    func format(with formatter: any KeyValueFormatter)
}

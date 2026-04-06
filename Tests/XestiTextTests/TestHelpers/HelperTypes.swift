// © 2026 John Gary Pusey (see LICENSE.md)

import XestiText

struct TestFormattable: KeyValueFormattable, Sendable {
    let name: String
    let value: Int

    func format(with formatter: inout some KeyValueFormatter) {
        formatter.add("name", name)
        formatter.add("value", value)
    }
}

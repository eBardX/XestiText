// © 2026 John Gary Pusey (see LICENSE.md)

import XestiText
import XestiTools

struct TestExtendedError: ExtendedError {
    var hints: [String] = []
    var hintsPrefix: String = "     - "
    var message: String
    var messagePrefix: String = "Error: "
}

struct TestFormattable: KeyValueFormattable, Sendable {
    let name: String
    let value: Int

    func format(with formatter: inout some KeyValueFormatter) {
        formatter.add("name", name)
        formatter.add("value", value)
    }
}

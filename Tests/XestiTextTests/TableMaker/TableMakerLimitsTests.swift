// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiText

struct TableMakerLimitsTests {
}

// MARK: -

extension TableMakerLimitsTests {
    @Test
    func test_values() {
        #expect(TableMaker.Limits.minimumColumnWidth == 1)
        #expect(TableMaker.Limits.minimumTableWidth == 1)
        #expect(TableMaker.Limits.maximumColumnWidth >= 80)
        #expect(TableMaker.Limits.maximumTableWidth >= 80)
    }
}

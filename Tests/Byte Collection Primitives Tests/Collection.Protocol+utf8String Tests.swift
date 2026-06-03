import Byte_Collection_Primitives_Test_Support
import Testing

// MARK: - Test Suite Structure
//
// Compound name backticked per the institute test-suite convention
// (matches swift-byte-serializer-primitives' `Byte.Serializer Tests` —
// backticked compound names are accepted by [SWIFT-TEST-002]; bare compound
// names are not).

@Suite
struct `Collection.Protocol utf8String Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

// MARK: - Unit Tests

extension `Collection.Protocol utf8String Tests`.Unit {
    @Test
    func `decodes a byte-collection of "hi" to the Swift.String "hi"`() {
        let bytes: [Byte] = [0x68, 0x69]  // "hi" — 0x68/0x69 inferred as Byte
        let collection = Collection.Fixture.Source<Byte>(bytes)

        #expect(collection.utf8String == "hi")
    }

    @Test
    func `decodes a multi-byte UTF-8 collection`() {
        // "Aé" — U+0041, U+00E9 (the latter encodes as 0xC3 0xA9 in UTF-8).
        let bytes: [Byte] = [0x41, 0xC3, 0xA9]
        let collection = Collection.Fixture.Source<Byte>(bytes)

        #expect(collection.utf8String == "Aé")
    }
}

// MARK: - Edge Case Tests

extension `Collection.Protocol utf8String Tests`.`Edge Case` {
    @Test
    func `empty byte-collection decodes to the empty string`() {
        let collection = Collection.Fixture.Source<Byte>([])

        #expect(collection.utf8String.isEmpty)
    }
}

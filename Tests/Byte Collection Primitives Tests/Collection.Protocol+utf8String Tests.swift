import Byte_Collection_Primitives_Test_Support
import Testing

@Suite
struct `Collection.Protocol utf8String Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Collection.Protocol utf8String Tests`.Unit {
    @Test
    func `decodes a byte-collection of "hi" to the Swift.String "hi"`() {
        let bytes: [Byte] = [0x68, 0x69]
        let collection = Collection.Fixture.Source<Byte>(bytes)

        #expect(collection.utf8String == "hi")
    }

    @Test
    func `decodes a multi-byte UTF-8 collection`() {

        let bytes: [Byte] = [0x41, 0xC3, 0xA9]
        let collection = Collection.Fixture.Source<Byte>(bytes)

        #expect(collection.utf8String == "Aé")
    }
}

extension `Collection.Protocol utf8String Tests`.`Edge Case` {
    @Test
    func `empty byte-collection decodes to the empty string`() {
        let collection = Collection.Fixture.Source<Byte>([])

        #expect(collection.utf8String.isEmpty)
    }
}

public import Byte_Primitives
public import Collection_Protocol_Primitives

extension Collection.`Protocol` where Element == Byte {

    public var utf8String: Swift.String {
        var bytes: [UInt8] = []
        var i = startIndex
        while i != endIndex {
            bytes.append(self[i].underlying)
            i = index(after: i)
        }
        return Swift.String(decoding: bytes, as: Swift.UTF8.self)
    }
}

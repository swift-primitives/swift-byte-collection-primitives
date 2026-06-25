// Collection.Protocol+utf8String.swift
//
// Bridges a byte-collection (`Collection.Protocol where Element == Byte`) to a
// UTF-8 `Swift.String`. This lives in the Standard Library Integration module
// because it materializes a stdlib `Swift.String` from the institute `Byte`
// and `Collection.Protocol` types: the institute layer stays
// stdlib-free, and the bridge to `Swift.String` is isolated here.
//
// Each element is unwrapped through `Byte`'s stored `underlying: UInt8` and
// collected into a `[UInt8]`, which `Swift.String(decoding:as:)` decodes as
// UTF-8 (replacing ill-formed sequences with U+FFFD per the stdlib contract).

public import Byte_Primitives
public import Collection_Protocol_Primitives

extension Collection.`Protocol` where Element == Byte {
    /// Decodes this byte-collection as a UTF-8 Swift.String.
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

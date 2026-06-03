// Byte Collection Primitives Test Support.swift
//
// Test Support is a thin re-export of the main target plus the upstream Byte
// and Collection fixtures. The byte-collection bridge needs no fixtures of its
// own: a byte-collection is constructed from `Collection.Fixture.Source<Byte>`
// (carried in `Collection Primitives Test Support`) and the bridge under test
// is a single computed property (`.utf8String`) — no cursor/slice or buffer
// infrastructure is required on this side.

# Byte Collection Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A cross-package bridge between the institute `Byte` type and the institute `Collection.Protocol`. It adds a single capability: decoding a byte-collection — any `Collection.Protocol` whose `Element` is `Byte` — as a UTF-8 `Swift.String`.

```swift
extension Collection.`Protocol` where Element == Byte {
    public var utf8String: Swift.String { ... }
}
```

This is a [`[MOD-014]`](https://github.com/swift-primitives) cross-package bridge: it owns no namespace root of its own, instead extending the upstream `Collection` namespace from [`swift-collection-primitives`](https://github.com/swift-primitives/swift-collection-primitives) over the `Byte` element type from [`swift-byte-primitives`](https://github.com/swift-primitives/swift-byte-primitives). Per `[PKG-NAME-016]` the name is recipient-then-provider: `byte` (the element being decoded) precedes `collection` (the protocol being extended).

---

## Quick Start

```swift
import Byte_Collection_Primitives

let bytes: [Byte] = [0x68, 0x69]              // "hi" — 0x68/0x69 inferred as Byte
let collection = Collection.Fixture.Source<Byte>(bytes)
let text = collection.utf8String              // "hi"
```

Any `Collection.Protocol` conformer over `Byte` gains `.utf8String`; the example uses the upstream test fixture for brevity.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-byte-collection-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Byte Collection Primitives", package: "swift-byte-collection-primitives"),
    ]
)
```

The package is pre-1.0 — until 0.1.0 is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`. Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

| Product | Target | Purpose |
|---------|--------|---------|
| `Byte Collection Primitives` | `Sources/Byte Collection Primitives/` | Umbrella. Re-exports the integration module plus the upstream `Byte` and `Collection.Protocol` namespaces. Zero implementation per `[MOD-005]`. |
| (internal) | `Sources/Byte Collection Primitives Standard Library Integration/` | The bridge itself: `Collection.Protocol where Element == Byte`'s `utf8String`. Lives in the Standard Library Integration module because it materializes a stdlib `Swift.String` (`[MOD-010]`). |
| `Byte Collection Primitives Test Support` | `Tests/Support/` | Re-export spine carrying upstream Byte and Collection test support (incl. `Collection.Fixture.Source`). |

The UTF-8 decode walks the collection by index (`startIndex` … `endIndex`, `index(after:)`), unwraps each `Byte` through its stored `underlying: UInt8`, and decodes the resulting `[UInt8]` with `Swift.String(decoding:as: UTF8.self)` (ill-formed sequences become U+FFFD per the stdlib contract).

Dependencies: [`swift-byte-primitives`](https://github.com/swift-primitives/swift-byte-primitives) (for `Byte` and its `underlying` accessor) and [`swift-collection-primitives`](https://github.com/swift-primitives/swift-collection-primitives) (for `Collection.Protocol`).

Foundation-free.

---

## Relationship to Other Packages

- [`swift-byte-primitives`](https://github.com/swift-primitives/swift-byte-primitives) — The `Byte` value type. The bridge decodes a collection of these. This package depends on it.
- [`swift-collection-primitives`](https://github.com/swift-primitives/swift-collection-primitives) — The `Collection.Protocol` extended here. This package depends on it.
- [`swift-byte-serializer-primitives`](https://github.com/swift-primitives/swift-byte-serializer-primitives) — Sibling byte-domain bridge package; this package mirrors its layout and conventions.

---

## License

Apache License 2.0 — see [LICENSE.md](LICENSE.md).

# Byte Collection Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Byte-domain collection utilities for Swift — set and predicate trimming, subsequence search, and UTF-8 `Swift.String` decoding for collections of `Byte`.

---

## Quick Start

The trimming and search helpers apply to any `Swift.Collection` whose elements are `Byte` — including a plain `[Byte]` — so they are available the moment you import the module.

```swift
import Byte_Collection_Primitives

// Strip leading and trailing linear white space from a header value.
let raw: [Byte] = [0x20, 0x09, 0x46, 0x6F, 0x6F, 0x20]   // " \tFoo "
let lwsp: Set<Byte> = [0x20, 0x09]                        // SPACE, HTAB
let value = raw.trimming(lwsp)                            // [0x46, 0x6F, 0x6F] — "Foo"

// Or trim by predicate.
let head = raw.trimming(where: { $0 == Byte(0x20) || $0 == Byte(0x09) })

// Locate a byte subsequence — e.g. a CRLF delimiter — without copying.
let line: [Byte] = [0x46, 0x6F, 0x6F, 0x0D, 0x0A]        // "Foo\r\n"
let crlf: [Byte] = [0x0D, 0x0A]
line.firstIndex(of: crlf)                                // 3
line.contains(crlf)                                      // true
```

Because these fire on the byte-domain element set (`Byte`, `ASCII.Code`, `Tagged<_, Byte>`) rather than on `UInt8`, they coexist with the standard-library `UInt8` overloads instead of competing with them.

Institute byte-collections additionally gain UTF-8 decoding: any `Collection.Protocol` whose `Element` is `Byte` exposes `.utf8String`, which walks the collection, unwraps each `Byte`, and decodes the bytes as UTF-8 (ill-formed sequences become U+FFFD per the standard-library contract).

```swift
extension Collection.`Protocol` where Element == Byte {
    public var utf8String: Swift.String { get }
}
```

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

The package is pre-1.0 — until `0.1.0` is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`.

---

## Architecture

| Product | Target | Purpose |
|---------|--------|---------|
| `Byte Collection Primitives` | `Sources/Byte Collection Primitives/` | Umbrella. Re-exports the integration target plus the upstream `Byte` and `Collection.Protocol` namespaces. |
| _(internal)_ | `Sources/Byte Collection Primitives Standard Library Integration/` | The extensions themselves: byte-domain `trimming(_:)` / `trimming(where:)`, `firstIndex(of:)` / `contains(_:)` subsequence search, and `Collection.Protocol`'s `utf8String`. Isolated here because it materializes a standard-library `Swift.String`. |
| `Byte Collection Primitives Test Support` | `Tests/Support/` | Re-export spine carrying the upstream `Byte` and `Collection` test fixtures for downstream test consumers. |

Depends on [`swift-byte-primitives`](https://github.com/swift-primitives/swift-byte-primitives) (for `Byte`) and [`swift-collection-primitives`](https://github.com/swift-primitives/swift-collection-primitives) (for `Collection.Protocol`).

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).

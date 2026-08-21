public import Byte_Primitives

extension Swift.Collection where Element: Byte.`Protocol` & Hashable {

    @inlinable
    public func trimming(_ byteSet: Set<Element>) -> SubSequence {
        var start = startIndex
        while start != endIndex, byteSet.contains(self[start]) {
            start = index(after: start)
        }
        if start == endIndex {
            return self[start..<start]
        }
        var lastNonTrimIndex = start
        var i = start
        while i != endIndex {
            if !byteSet.contains(self[i]) {
                lastNonTrimIndex = i
            }
            i = index(after: i)
        }
        let end = index(after: lastNonTrimIndex)
        return self[start..<end]
    }

    @inlinable
    public func trimming(where predicate: (Element) -> Bool) -> SubSequence {
        var start = startIndex
        while start != endIndex, predicate(self[start]) {
            start = index(after: start)
        }
        if start == endIndex {
            return self[start..<start]
        }
        var lastNonTrimIndex = start
        var i = start
        while i != endIndex {
            if !predicate(self[i]) {
                lastNonTrimIndex = i
            }
            i = index(after: i)
        }
        let end = index(after: lastNonTrimIndex)
        return self[start..<end]
    }
}

extension Swift.Collection where Element: Byte.`Protocol` & Equatable {

    @inlinable

    public func firstIndex<C: Swift.Collection>(of needle: C) -> Index?
    where C.Element == Element {
        guard !needle.isEmpty else { return startIndex }
        guard needle.count <= count else { return nil }
        var i = startIndex
        let searchEnd = index(endIndex, offsetBy: -needle.count + 1)
        while i < searchEnd {
            var matches = true
            var selfIndex = i
            var needleIndex = needle.startIndex
            while needleIndex != needle.endIndex {
                if self[selfIndex] != needle[needleIndex] {
                    matches = false
                    break
                }
                selfIndex = index(after: selfIndex)
                needleIndex = needle.index(after: needleIndex)
            }
            if matches {
                return i
            }
            i = index(after: i)
        }
        return nil
    }

    @inlinable

    public func contains<C: Swift.Collection>(_ needle: C) -> Bool
    where C.Element == Element {
        firstIndex(of: needle) != nil
    }
}

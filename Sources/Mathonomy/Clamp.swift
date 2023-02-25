import CoreGraphics

public func clamp<T: Numeric & Comparable>(_ value: T, from: T = 0, to: T = 1) -> T {
    if value < from { return from }
    if value > to { return to }
    return value
}

public extension Int {
    func clamped(from:Self = 0, to:Self = 1) -> Self {
        clamp(self, from: from, to: to)
    }
}

public extension Double {
    func clamped(from:Self = 0, to:Self = 1) -> Self {
        clamp(self, from: from, to: to)
    }
}

public extension CGFloat {
    func clamped(from:Self = 0, to:Self = 1) -> Self {
        clamp(self, from: from, to: to)
    }
}

public extension CGPoint {
    func clamped(from:Self = CGPoint(x: 0, y: 0), to:Self = CGPoint(x: 1, y: 1)) -> Self {
        CGPoint(x: x.clamped(from: from.x, to: to.x), y: y.clamped(from: from.y, to: to.y))
    }
}

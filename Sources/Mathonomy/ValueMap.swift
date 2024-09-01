
import Foundation
import CoreGraphics

public func map<T: BinaryFloatingPoint>(value: T, sourceMin:T, sourceMax:T, targetMin:T, targetMax:T) -> T {
    (targetMax - targetMin) * ((value - sourceMin) / (sourceMax - sourceMin)) + targetMin
}

public func map<T: BinaryFloatingPoint>(value: T, inSourceRange source: ClosedRange<T>, toTargetRange target: ClosedRange<T>) -> T {
    (target.upperBound - target.lowerBound) * ((value - source.lowerBound) / (source.upperBound - source.lowerBound)) + target.lowerBound
}


public extension BinaryFloatingPoint {
    
    func mapIn(sourceMin:Self, sourceMax:Self, targetMin:Self, targetMax:Self) -> Self {
        map(value: self, sourceMin: sourceMin, sourceMax: sourceMax, targetMin: targetMin, targetMax: targetMax)
    }
    
    func mapIn(sourceRange source:ClosedRange<Self>, toTargetRange target:ClosedRange<Self>) -> Self {
        mapIn(sourceMin: source.lowerBound, sourceMax: source.upperBound, targetMin: target.lowerBound, targetMax: target.upperBound)
    }

    func mapToNormal(sourceRange source:ClosedRange<Self>) -> Self {
        mapIn(sourceRange: source, toTargetRange: 0...1)
    }
    
    func invert(sourceRange source:ClosedRange<Self>) -> Self {
        (source.upperBound - self) + source.lowerBound
    }
    
    func invertInNormalRange() -> Self {
        invert(sourceRange: 0...1)
    }


}

public extension CGPoint {
    
    func mapToNormal(sourceRange source:ClosedRange<CGFloat>) -> Self {
        mapIn(sourceRange: source, toTargetRange: 0...1)
    }
    
    func mapIn(sourceRange source:ClosedRange<CGFloat>, toTargetRange target:ClosedRange<CGFloat>) -> Self {
        CGPoint(
            x: x.mapIn(sourceRange: source, toTargetRange: target),
            y: y.mapIn(sourceRange: source, toTargetRange: target)
        )
    }
    
    func mapIn(sourceRect source:CGRect, toTargetRect target:CGRect) -> Self {
        CGPoint(
            x: x.mapIn(sourceRange: source.minX...source.maxX, toTargetRange: target.minX...target.maxX),
            y: y.mapIn(sourceRange: source.minY...source.maxY, toTargetRange: target.minY...target.maxY)
        )
    }
    
    func mapToNormal(sourceRect source:CGRect) -> Self {
        self.mapIn(sourceRect: source, toTargetRect: .init(x: 0, y: 0, width: 1, height: 1))
    }
    
    func mapToNormal(sourceSize source:CGSize) -> Self {
        self.mapToNormal(sourceRect: .init(origin: .zero, size: source))
    }
    
    func map(keyPath target: WritableKeyPath<CGPoint,CGFloat>, _ f:(CGFloat) -> (CGFloat)) -> Self {
        var copy = self
        copy[keyPath: target] = f(copy[keyPath: target])
        return copy
    }
    
}


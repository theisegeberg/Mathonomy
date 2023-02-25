
import CoreGraphics

public protocol Interpolatable {
    func difference<T:BinaryFloatingPoint>(from:Self) -> T
    func interpolate<T:BinaryFloatingPoint>(to:Self, t:T) -> Self
    func interpolate(to:Self, divisions:Int) -> [Self]
}


public extension Interpolatable {
    func interpolate(to: Self, divisions: Int) -> [Self] {
        (0..<divisions).map { currentDivision in
            interpolate(to: to, t: currentDivision.divided(by: divisions))
        }
    }
}


public extension Interpolatable where Self:BinaryFloatingPoint {
    func difference<T>(from: Self) -> T where T : BinaryFloatingPoint {
        T(abs(self - from))
    }
    func interpolate<T>(to: Self, t: T) -> Self where T : BinaryFloatingPoint {
        self + Self(t) * (to - self);
    }
}
extension CGFloat:Interpolatable {}
extension Double:Interpolatable {}


extension CGPoint:Interpolatable {
    
    public func difference<T:BinaryFloatingPoint>(from: CGPoint) -> T {
        T(self.distanceTo(from))
    }
    
    public func interpolate<T:BinaryFloatingPoint>(to: CGPoint, t: T) -> CGPoint {
        .init(x: x.interpolate(to: to.x, t: t), y: y.interpolate(to: to.y, t: t))
    }
}


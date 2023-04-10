
import Foundation
import CoreGraphics

public extension BinaryFloatingPoint where Self:Interpolatable {
    
    func quadratic(to:Self, withControl c1:Self,time:Double) -> Self {
        let lerp1 = self.interpolate(to: c1, t: time)
        let lerp2 = c1.interpolate(to: to, t: time)
        return lerp1.interpolate(to: lerp2, t: time)
    }

    func quadratic(to:Self, withControl c1:Self) -> (_ time:Double) -> Self {
        { (time:Double) -> Self in
            self.quadratic(to: to, withControl: c1, time: time)
        }
    }
    
    func cubic(to:Self, withControlA c1:Self, andControlB c2:Self,time:Double) -> Self {
        let lerp1 = self.quadratic(to: c2, withControl: c1, time: time)
        let lerp2 = c1.quadratic(to: to, withControl: c2, time: time)
        return lerp1.interpolate(to: lerp2, t: time)
    }
    
    func cubic(to:Self, withControlA c1:Self, andControlB c2:Self) -> (_ time:Double) -> Self {
        { (time:Double) -> Self in
            self.cubic(to: to, withControlA: c1, andControlB: c2, time: time)
        }
    }
    
}

public extension CGPoint {
    
    func quadratic(to:Self, withControl c1:Self,time:Double) -> Self {
        CGPoint(
            x: x.quadratic(to: to.x, withControl: c1.x, time: time),
            y: y.quadratic(to: to.y, withControl: c1.y, time: time)
        )
    }
    
    
    func cubic(to:Self, withControlA c1:Self, andControlB c2:Self,time:Double) -> Self {
        CGPoint(
            x: x.cubic(to: to.x, withControlA: c1.x, andControlB: c2.x, time: time),
            y: y.cubic(to: to.y, withControlA: c1.y, andControlB: c2.y, time: time)
        )
    }
    
    func cubicSampled(end:Self, withControlA c1:Self, andControlB c2:Self, maxDepth:Int, precision:Int) -> (_ x:Double) -> Self {
        let search = BezierLinearSearch(start: self, end: end, controlA: c1, controlB: c2, maxDepth: maxDepth, precision: precision)
        return {
            (x:Double) -> Self in
            search.sample(targetX: x)
        }
    }
    
    
}



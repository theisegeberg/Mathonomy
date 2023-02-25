
import CoreGraphics

extension CGPoint {
    
    public func move(distance:Double, alongRadians radians:Double) -> CGPoint {
        self + CGPoint(x: cos(radians) * distance, y: sin(radians) * distance)
    }
    
    public func move(distance:Double, alongVectorFormedByOtherPoint p:CGPoint) -> CGPoint {
        return move(
            distance: distance,
            alongRadians: angle(to: p)
        )
    }
}


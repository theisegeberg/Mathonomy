
import CoreGraphics

extension CGPoint {
    
    public func slopeIntercept(for other: CGPoint) -> (slope:Double, yIntercept:Double) {
        let slope = (other.y - self.y) / (other.x - self.x)
        return (slope: slope, yIntercept: self.y - (slope * self.x))
    }
    
}


import CoreGraphics

extension CGPoint {
    
    public func slope(for other:CGPoint) -> Double {
        (other.y - self.y) / (other.x - self.x)
    }
    
    public func yIntercept(forSlope slope:Double) -> Double {
        self.y - (slope * self.x)
    }
    
    public func slopeIntercept(for other: CGPoint) -> (slope:Double, yIntercept:Double) {
        let slope = slope(for: other)
        return (slope: slope, yIntercept: yIntercept(forSlope: slope))
    }
    
    public func slopeIntercept(for other: CGPoint, calculatingYforX x:Double) -> (Double) {
        let slope = slope(for: other)
        return slope * x + yIntercept(forSlope: slope)
    }
    
}

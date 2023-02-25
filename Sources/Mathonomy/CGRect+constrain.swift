
import CoreGraphics

public extension CGRect {
    
    /// Constrain an x to the size of the rect
    /// - Parameter x: value to constrain
    /// - Returns: An x between the min and max of the rect
    func constrain(x:Double) -> Double {
        if x < minX {
            return minX
        }
        if x > maxX {
            return maxX
        }
        return x
    }
    
    /// Constrain an value to the size of the rect
    /// - Parameter y: value to constrain
    /// - Returns: An y between the min and max of the rect
    func constrain(y:Double) -> Double {
        if y < minY {
            return minY
        }
        if y > maxY {
            return maxY
        }
        return y
    }
    
}

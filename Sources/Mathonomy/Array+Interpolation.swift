
import Foundation

public extension Array where Element:BinaryFloatingPoint {
    
    private var step:Element {
        guard isEmpty == false else {
            return 1
        }
        return 1 / Element(count)
    }
    
    /// Derives a function for the particular angle where X is found
    func derivedFunction(forX x:Element) -> (Element) -> Element {
        guard self.count > 0 else {
            return { _ in 0 }
        }
        guard self.count > 1 else {
            return { _ in self.first! }
        }
        let d = floor(x / step)
        let proposedIndex = Int(d.isNaN ? 0.5 : d)
        let indexA = proposedIndex >= 0 ? proposedIndex : 0
        let indexB = indexA + 1
        guard indexB < self.count else {
            return { _ in self.last ?? 0 }
        }
        let x1 = Element(indexA) * step
        let y1 = self[indexA]
        let y2 = self[indexB]
        return {
            let t = $0 - x1
            return ((1.0 - t) * y1) + (t * y2)
        }
    }
    
}

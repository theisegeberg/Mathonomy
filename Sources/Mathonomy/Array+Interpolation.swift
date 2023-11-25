
import Foundation

public extension Array where Element == Double {
    
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
        let indexes = (0...self.endIndex).rangeBounding(normalisedZeroToOne: x)
        let x1 = Double(indexes.lowerBound) * step
        let (y1,y2) = elements(atStartAndEndOfRange: indexes)
        return {
            let t = $0 - x1
            return ((1.0 - t) * y1) + (t * y2)
        }
    }
    
    /// Derives a function for the particular angle where X is found
    func value(forNormalisedX x:Element) -> Element {
        guard self.count > 0 else {
            return 0
        }
        guard self.count > 1 else {
            return self.first!
        }
        let indexes = (0...(self.endIndex-1)).rangeBounding(normalisedZeroToOne: x)
        let x1 = Double(indexes.lowerBound) * step
        let (y1,y2) = elements(atStartAndEndOfRange: indexes)
        let t = x - x1
        return ((1.0-t) * y1) + (t * y2)
    }
    
}



public extension ClosedRange where Bound == Int {
    func rangeBounding(normalisedZeroToOne normalised:Double) -> Self {
        precondition(normalised >= 0)
        precondition(normalised <= 1)
        let span = Double(self.upperBound - self.lowerBound)
        let fraction = span * normalised
        let lesserThan = Int(floor(fraction)) + self.lowerBound
        let greaterThan = Int(ceil(fraction)) + self.lowerBound
        return lesserThan...greaterThan
    }
}

public extension Array {
    func elements(atStartAndEndOfRange range:ClosedRange<Index>) -> (Element,Element) {
        precondition(range.lowerBound>=self.startIndex)
        precondition(range.upperBound<self.endIndex)
        return (self[range.lowerBound],self[range.upperBound])
    }
}

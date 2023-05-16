
import Foundation
import CoreGraphics

public struct BezierLinearSearch {
    
    private let start:CGPoint
    private let end:CGPoint
    private let controlA:CGPoint
    private let controlB:CGPoint
    private let precisionFraction:Double
    private let horizontalSearch:HorizontalSearch<CGFloat,CGPoint>
    
    public init(
        start: CGPoint,
        end: CGPoint,
        controlA: CGPoint,
        controlB: CGPoint,
        maxDepth: Int,
        precision: Int) {
            let startPoint = start
            let endPoint = end
            self.start = startPoint
            self.end = endPoint
            self.controlA = controlA
            self.controlB = controlB
            self.precisionFraction = 1.divided(by: precision)
            self.horizontalSearch = HorizontalSearch(
                sourceEquation:
                { time in
                    startPoint.cubic(to: endPoint, withControlA: controlA, andControlB: controlB, time: time)
                },
                maximumDepth: maxDepth)
        }
    
    
    public func sample(targetX:Double) -> CGPoint {
        let (possiblePreviousMatch, matchingPoint) = horizontalSearch
            .search(
                lowerBound: start.x,
                upperBound: end.x) {
                    candidate in
                    if abs(targetX - candidate.x) < precisionFraction {
                        return .found
                    }
                    if targetX > candidate.x {
                        return .under
                    }
                    if targetX < candidate.x {
                        return .over
                    }
                    return .found
                }
        guard let previousMatch = possiblePreviousMatch else {
            return matchingPoint
        }
        let y = previousMatch.slopeIntercept(for: matchingPoint, calculatingYforX: targetX)
        return CGPoint(x: targetX, y: y)
    }
    
    public func cachedSampling0To1(samples:Int) -> (_ x:Double) -> (Double) {
        let results = stride(from: 0, through: 1, by: 1 / Double(samples)).map { x in
            Double(sample(targetX: x).y)
        }
        return {
            x in
            results.value(forNormalisedX: x)
        }

    }
    
    
    
}

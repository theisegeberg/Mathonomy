
import Foundation
import CoreGraphics

public struct BezierLinearSearch {
    
    private let start:CGPoint
    private let end:CGPoint
    private let controlA:CGPoint
    private let controlB:CGPoint
    private let precisionFraction:Double
    private let horizontalSearch:HorizontalSearch
    
    public init(
        startY: CGFloat,
        endY: CGFloat,
        controlA: CGPoint,
        controlB: CGPoint,
        maxDepth: Int,
        precision: Int) {
            let startPoint = CGPoint(x: 0, y: startY)
            let endPoint = CGPoint(x: 1, y: endY)
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
   
    
    public func sample(targetX:CGFloat) -> CGPoint {
        let (possiblePreviousMatch, matchingPoint) = horizontalSearch
            .search(
                lowerBound: (targetX - 0.5).clamped(),
                upperBound: (targetX + 0.5).clamped()) {
                    candidate in
                    if abs(targetX - candidate) < precisionFraction {
                        return .found
                    }
                    if targetX > candidate {
                        return .under
                    }
                    if targetX < candidate {
                        return .over
                    }
                    return .found
                }
        guard let previousMatch = possiblePreviousMatch else {
            return matchingPoint
        }
        let (slope, intercept) = previousMatch.slopeIntercept(for: matchingPoint)
        return CGPoint(x: targetX, y: slope * targetX + intercept)
    }
    
    
    
}

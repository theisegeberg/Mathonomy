
import Foundation
import CoreGraphics

public enum SearchResult {
    case found, over, under
}

public struct HorizontalSearch {
    let sourceEquation:(CGFloat) -> CGPoint
    let maximumDepth:Int
    
    public init(
        sourceEquation:@escaping (CGFloat) -> CGPoint,
        maximumDepth:Int
    ) {
        self.sourceEquation = sourceEquation
        self.maximumDepth = maximumDepth
    }
    
    public func search(
        lowerBound:CGFloat = 0,
        upperBound:CGFloat = 1,
        currentDepth:Int = 0,
        previousResult:CGPoint? = nil,
        resultValidator:@escaping (CGFloat) -> SearchResult
    )
    ->
    (previousResult:CGPoint?, result:CGPoint) {
        precondition(upperBound > lowerBound, "Binary search failed upper bound (\(upperBound)) was below lower bound (\(lowerBound)")
        precondition(upperBound > 0)
        precondition(lowerBound < 1)
        precondition(currentDepth >= 0)
        precondition(maximumDepth >= currentDepth)
        
        // The guess is between the lower and upper bound.
        let halfwayBetweenUpperAndLowerBound = (lowerBound + upperBound) / 2
        let proposedResult = sourceEquation(halfwayBetweenUpperAndLowerBound)
        
        // If the depth is too great return the currently found values.
        guard currentDepth < maximumDepth else {
            return (previousResult, proposedResult)
        }
        
        // Check if the result is good enough, too high or too low
        switch resultValidator(proposedResult.x) {
            case .found:
                return (previousResult, proposedResult)
            case .over:
                return search(
                    lowerBound: lowerBound,
                    upperBound: halfwayBetweenUpperAndLowerBound,
                    currentDepth: currentDepth + 1,
                    previousResult: proposedResult,
                    resultValidator: resultValidator
                )
            case .under:
                return search(
                    lowerBound: halfwayBetweenUpperAndLowerBound,
                    upperBound: upperBound,
                    currentDepth: currentDepth + 1,
                    previousResult: proposedResult,
                    resultValidator: resultValidator
                )
        }
    }
    
}


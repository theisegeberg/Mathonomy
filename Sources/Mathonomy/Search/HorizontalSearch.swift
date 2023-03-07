
import Foundation
import CoreGraphics

public struct HorizontalSearch<Input:BinaryFloatingPoint,Output> {

    public enum SearchResult {
        case found, over, under
    }
    
    private let sourceEquation:(Input) -> Output
    private let maximumDepth:Int
    
    public init(
        sourceEquation:@escaping (Input) -> Output,
        maximumDepth:Int
    ) {
        self.sourceEquation = sourceEquation
        self.maximumDepth = maximumDepth
    }
    
    public func search(
        lowerBound:Input,
        upperBound:Input,
        currentDepth:Int = 0,
        previousResult:Output? = nil,
        resultValidator:(Output) -> SearchResult
    )
    ->
    (previousResult:Output?, result:Output) {
        precondition(upperBound > lowerBound, "Binary search failed upper bound (\(upperBound)) was below lower bound (\(lowerBound)")
        precondition(currentDepth >= 0)
        precondition(maximumDepth >= currentDepth)
        
        // The guess is between the lower and upper bound.
        let halfwayBetweenUpperAndLowerBound = (lowerBound + upperBound) / 2
        let proposedResult = sourceEquation(halfwayBetweenUpperAndLowerBound)
        
        // If the depth is too great return the currently found values.
        guard currentDepth < maximumDepth else {
            return (previousResult, proposedResult)
        }
        
        return withoutActuallyEscaping(resultValidator) { resultValidator in
            // Check if the result is good enough, too high or too low
            switch resultValidator(proposedResult) {
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
    
}


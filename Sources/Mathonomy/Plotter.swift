public struct Plotter {
    private let range:ClosedRange<Double>
    private let sampleCount:Int
    
    public init(samples sampleCount:Int, inRange range: ClosedRange<Double>) {
        guard sampleCount > 1 else {
            assertionFailure("Invalid sample count \(sampleCount)")
            self.range = range
            self.sampleCount = 2
            return
        }
        self.range = range
        self.sampleCount = sampleCount
    }
    
    public func plot<T>(
        _ f:@escaping (Double) -> Double,
        transform: @escaping (_ x:Double,_ y:Double) -> T) -> LazyMapSequence<StrideThrough<Double>, T> {
        plot().lazy.map {
            transform($0, f($0))
        }
    }
    
    public func plot() -> StrideThrough<Double> {
        stride(
            from: range.lowerBound,
            through: range.upperBound,
            by: (range.upperBound / Double(sampleCount-1))
        )
    }
}

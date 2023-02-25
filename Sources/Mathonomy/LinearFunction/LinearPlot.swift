
import CoreGraphics

public struct LinearPlot {
    private let range:ClosedRange<Double>
    private let samples:Int
    
    public static let normal100:Self = .init(range: 0...1, samples: 100)
    
    public init(range: ClosedRange<Double>, samples: Int) {
        self.range = range
        self.samples = samples
    }
    
    public func plot<T>(_ f:(Double) -> Double, transform:(_ x:Double,_ y:Double) -> T) -> [T] {
        stride(
            from: range.lowerBound,
            through: range.upperBound,
            by: range.upperBound / Double(samples)
        )
        .map {
            transform($0, f($0))
        }
    }
    
    public func plot<T>(_ f:LinearFunction, transform:(_ x:Double,_ y:Double) -> T) -> [T] {
        plot(f.evaluate, transform: transform)
    }
    
}


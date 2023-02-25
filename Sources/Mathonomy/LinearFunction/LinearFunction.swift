
import Foundation

infix operator => : AssignmentPrecedence

public struct LinearFunction {
    
    private let f:(Double) -> Double
    private static let blackmanSet = blackmanWindow(count: 5000)
    
    public init(f: @escaping (Double) -> Double) {
        self.f = f
    }
    
    public func evaluate(_ value:Double) -> Double {
        f(value)
    }
    
    public func map(_ f:LinearFunction) -> LinearFunction {
        LinearFunction {
            f.evaluate(self.evaluate($0))
        }
    }
    
    public func map(_ f:@escaping (Double) -> Double) -> LinearFunction {
        LinearFunction {
            f(self.evaluate($0))
        }
    }
    
    public func invert() -> LinearFunction {
        LinearFunction {
            self.evaluate($0.inverted)
        }
    }
    
    public func verticalStretch(aroundCenter center:Double, amount:Double) -> LinearFunction {
        LinearFunction { x in
            let y = self.evaluate(x)
            return ((y - center) * (amount + 1)) + center
        }
    }
    
    public func horizontalStretch(aroundCenter center:Double, amount:Double) -> LinearFunction {
        LinearFunction { x in
            self.evaluate(((x - center) * (1 / amount)) + center)
        }
    }
    
    public func verticalShift(aroundCenter center:Double, _ amount:Double) -> LinearFunction {
        LinearFunction { x in
            self.evaluate(x) - center + amount
        }
    }
    
    public func horizontalShift(_ shift:Double) -> LinearFunction {
        LinearFunction { x in
            self.evaluate(x + shift)
        }
    }

    public func abs() -> LinearFunction {
        LinearFunction {
            sqrt(self.evaluate($0) * self.evaluate($0))
        }
    }

    
    public func skewed(_ amount:Double) -> LinearFunction {
        Self.pow10Exponential01(exponent: amount) => self
    }
    
    public func bloated(_ amount:Double) -> LinearFunction {
        self => Self.pow10Exponential01(exponent: amount)
    }
    
    public func influence(by influencer:LinearFunction) -> InfluencedLinearFunction {
        .init(influence: influencer, value: self)
    }
    
    public func multiplied(by amount:Double) -> LinearFunction {
        LinearFunction {
            self.evaluate($0) * amount
        }
    }
    
    public func multiplied(by linearFunction:LinearFunction) -> LinearFunction {
        LinearFunction {
            self.evaluate($0) * linearFunction.evaluate($0)
        }
    }
    
    public static func => (lhs: LinearFunction, rhs: LinearFunction) -> LinearFunction {
        lhs.map(rhs)
    }
    
    public static func * (lhs: LinearFunction, rhs: LinearFunction) -> LinearFunction {
        LinearFunction {
            lhs.evaluate($0) * rhs.evaluate($0)
        }
    }
    
    public static func + (lhs: LinearFunction, rhs: LinearFunction) -> LinearFunction {
        LinearFunction {
            lhs.evaluate($0) + rhs.evaluate($0)
        }
    }
    
    public static func pow10Exponential01(exponent:Double) -> LinearFunction {
        LinearFunction {
            $0.exponential01Linear(normalisedExponent: exponent)
        }
    }
    
    public static func linear(slope:Double, intercept:Double) -> LinearFunction {
        LinearFunction {
            ($0 * slope) + intercept
        }
    }
    
    public static var zero:LinearFunction {
        .just(0)
    }
    
    public static func linear(from pointA:CGPoint, to pointB:CGPoint) -> LinearFunction {
        let slopeIntercept = pointA.slopeIntercept(for: pointB)
        return .linear(slope: slopeIntercept.slope, intercept: slopeIntercept.yIntercept)
    }
    
    public static func just(_ value:Double) -> LinearFunction {
        LinearFunction { _ in
            value
        }
    }
    
    public static func blackman() -> LinearFunction {
        LinearFunction {
            blackmanSet.derivedFunction(forX: $0)($0)
        }
    }
    
    public static func squeezedBlackman(exponent:Double) -> LinearFunction {
        blackman() => pow10Exponential01(exponent: exponent)
    }
    
    public static func skewedBlackman(exponent:Double) -> LinearFunction {
        pow10Exponential01(exponent: exponent) => blackman()
    }
    
    public static func witchOfAgnesi(height:Double) -> LinearFunction {
        LinearFunction {
            (8 * pow(height,3)) / (pow($0.mapIn(sourceRange: 0...1, toTargetRange: -5...5), 2) + (4 * pow(height,2))).mapIn(sourceRange: -5...5, toTargetRange: 0...1)
        }
    }
    
    public static func invertedBumpCosine() -> LinearFunction {
        LinearFunction {
            if $0 < 0 {
                return 0
            }
            if $0 > 1 {
                return 0
            }
            return 1 - ((cos($0 * Double.pi * 2) + 1) / 2)
        }
    }
    
    public struct InfluencedLinearFunction {
        
        struct PlotResult {
            let influence:Double
            let value:Double
        }
        
        public let influence:LinearFunction
        public let value:LinearFunction
        
        func plot(forX x:Double) -> PlotResult {
            .init(influence: influence.evaluate(x), value: value.evaluate(x))
        }
        
    }
    
    public static func influencedLine(_ functionSets:InfluencedLinearFunction...) -> LinearFunction {
        LinearFunction { x in
            let influencesAndValues = functionSets.map {
                $0.plot(forX: x)
            }
            let sumOfInfluences = influencesAndValues.map(\.influence).reduce(0, +)
            let result = influencesAndValues.map {
                ($0.influence / sumOfInfluences) * $0.value
            }.reduce(0, +)
            return result
        }
    }
    
}



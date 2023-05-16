
import Foundation
import Numerics

public extension Double {
    func exponential01(exponent:Self) -> Self {
        guard exponent != 1 else {
            return self
        }
        return (Double.pow(exponent, self) - 1) / (exponent - 1)
    }
    
    func exponential01Linear(normalisedExponent:Self) -> Self {
        exponential01(exponent: Double.pow(10, normalisedExponent))
    }
}



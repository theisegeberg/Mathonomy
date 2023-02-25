
import Foundation

public extension Int {
    func float<T:BinaryFloatingPoint>() -> T {
        T(self)
    }
}

public extension Double {
    func int<T:SignedInteger>() -> T {
        T(self)
    }
}


import Foundation
import Numerics

public extension Double {
    static func sigmoid(_ x:Double) -> Double {
        return 1 / (1 + exp(-x))
    }
}

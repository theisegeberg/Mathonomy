
import Foundation
import Numerics

public extension Double {
    static func witchOfAgnesi(height:Double) -> (Double) -> Double {
        {
            (8 * pow(height,3)) / (pow($0, 2) + (4 * pow(height,2)))
        }
    }
}


import Foundation
import Accelerate

public func blackmanWindow(count:Int) -> [Double] {
    vDSP.window(ofType: Double.self,
                usingSequence: .blackman,
                count: count,
                isHalfWindow: false)
}

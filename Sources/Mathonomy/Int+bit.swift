
import Foundation

public extension Int {
    func pow(_ power:UInt) -> Int {
        if power == 0 { return 1 }
        if self == 2 { return 2 << Int(power - 1) }
        return repeatElement(self, count: Int(power)).reduce(1, *)
    }
}

public extension Int {
    var bitMaxValue: Int {
        2.pow(UInt(self)) - 1
    }
}

public func bit16ToBit8(_ bit16Value: Int) -> Int {
    (8.bitMaxValue.multiplied(by: bit16Value.divided(by: 16.bitMaxValue))).int()
}


import XCTest
@testable import Mathonomy

final class BezierTests: XCTestCase {
    func testBezier() {
        let max = 100
        for i in 0...max {
            let fraction = i.divided(by: max)
            XCTAssertEqual(fraction, Double(0).cubic(to: 1, withControlA: 1.divided(by: 3), andControlB: 1.divided(by: 3) * 2, time: fraction), accuracy: 0.0001)
            
        }
        
    }
}

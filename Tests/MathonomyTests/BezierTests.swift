
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
    
    func testIndexFinding() {
        XCTAssertEqual((4...5).rangeBounding(normalisedZeroToOne: 0.5), 4...5)
        XCTAssertEqual((4...5).rangeBounding(normalisedZeroToOne: 0), 4...4)
        XCTAssertEqual((4...5).rangeBounding(normalisedZeroToOne: 1), 5...5)
        XCTAssertEqual((0...9).rangeBounding(normalisedZeroToOne: 0.5), 4...5)
        let e1 = [0,4,8,12].elements(atStartAndEndOfRange: 0...2)
        XCTAssertEqual(e1.0, 0)
        XCTAssertEqual(e1.1, 8)
        let e2 = [0,4,8,12].elements(atStartAndEndOfRange: 3...3)
        XCTAssertEqual(e2.0, 12)
        XCTAssertEqual(e2.1, 12)
        
        let a1 = Array<Double>(arrayLiteral: 0,1,2,3,4,5,6,7,8,9,10,11)
        let i1 = (0...a1.count).rangeBounding(normalisedZeroToOne: 0.2)
        let es1 = a1.elements(atStartAndEndOfRange:i1)
        XCTAssertEqual(es1.0, 2)
        XCTAssertEqual(es1.1, 3)

    }
    
    func testPresampledBezier() {
        let pS = CGPoint.zero
        let pSc = CGPoint(x: 0.4, y: 0.25)
        let pE = CGPoint.one
        let pEc = CGPoint(x: 0.75, y: 0.75)
        
        
        let search2 = printTimeElapsedWhenRunningCode(title: "Create simple search") {
            BezierLinearSearch(start: pS, end: pE, controlA: pSc, controlB: pEc, maxDepth: 100, precision: 10000000)
        }
        let a1 = printTimeElapsedWhenRunningCode(title: "Plot simple") {
            LinearPlot(range: 0...1, samples: 5000).plot {
                search2.sample(targetX: $0).y
            }
        }

        let cached = printTimeElapsedWhenRunningCode(title: "Create cache search") {
            search2.cachedSampling0To1(samples: 5000)
        }
        let a2 = printTimeElapsedWhenRunningCode(title: "Plot cache") {
            LinearPlot(range: 0...1, samples: 5000).plot {
                cached($0)
            }
        }
        XCTAssertEqual(Array(a1), Array(a2))
    }
    
    func printTimeElapsedWhenRunningCode<T>(title:String, operation:()->(T)) -> T {
        let startTime = CFAbsoluteTimeGetCurrent()
        let t = operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title):\n\(timeElapsed) s.")
        return t
    }

}

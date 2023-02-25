

import XCTest
@testable import Mathonomy

final class SearchTests: XCTestCase {
    
    func testSearch() {
        let search = HorizontalSearch(sourceEquation: { (time:CGFloat) in
            return CGPoint(x: time, y: pow(time, 2))
        }, maximumDepth: 100)
        let result1 = search.search { x in
            if x < 0.1 {
                return .under
            }
            if x > 0.4 {
                return .over
            }
            return .found
        }
        XCTAssertEqual(result1.result.x, 0.25, accuracy: 0.0001)
        XCTAssertEqual(result1.result.y, 0.0625, accuracy: 0.0001)
        
        let result2 = search.search { x in
            if x < 0.1 {
                return .under
            }
            if x > 0.12 {
                return .over
            }
            return .found
        }
        print(result2)
        XCTAssertEqual(pow(0.109375,2), result2.result.y, accuracy: 0.0001)
    }
    
    func testBezierSearch() {
        
        let bezierSearch1 = BezierLinearSearch(
            startY: 0,
            endY: 0,
            controlA: CGPoint(x: 1, y: 1),
            controlB: CGPoint(x: 0, y: 1),
            maxDepth: 10,
            precision: 10
        )
        XCTAssertEqual(bezierSearch1.sample(targetX: 0.5).y, 0.75)
        XCTAssertEqual(bezierSearch1.sample(targetX: 0.1).y, bezierSearch1.sample(targetX: 0.9).y, accuracy: 0.00001)
        
        
        let bezierSearch2 = BezierLinearSearch(
            startY: 1,
            endY: 1,
            controlA: CGPoint(x: 1, y: 0),
            controlB: CGPoint(x: 0, y: 0),
            maxDepth: 10,
            precision: 10
        )
        XCTAssertEqual(bezierSearch2.sample(targetX: 0.5).y, 0.25)
        XCTAssertEqual(bezierSearch2.sample(targetX: 0.1).y, bezierSearch2.sample(targetX: 0.9).y, accuracy: 0.00001)
    }
    
    
    
}


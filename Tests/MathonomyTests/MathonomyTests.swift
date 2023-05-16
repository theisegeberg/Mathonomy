import XCTest
@testable import Mathonomy

final class MathonomyTests: XCTestCase {

    let int0:Int = 0
    let int10:Int = 10
    let float0:CGFloat = 0
    let float10:CGFloat = 10
    let floatn10:CGFloat = -10
    let point0_0 = CGPoint(x: 0, y: 0)
    let point1_1 = CGPoint(x: 1, y: 1)
    let point10_n10 = CGPoint(x: 10, y: -10)
    let point5_5 = CGPoint(x: 5, y: 5)
    let point10_10 = CGPoint(x: 10, y: 10)
    
    func testDistance() {
        XCTAssertEqual(point1_1.distanceTo(point10_n10), 14.212670403551895)
        XCTAssertEqual(float0.difference(from: float10), 10)
        XCTAssertEqual(float10.difference(from: float0), 10)
    }
    
    func testInterpolate() {
        XCTAssertEqual(float0.interpolate(to: float10, t: 0.1), 1)
        XCTAssertEqual(float10.interpolate(to: float0, t: 0.1), 9)
        XCTAssertEqual(float10.interpolate(to: floatn10, t: 0.5), 0)
        XCTAssertEqual(float10.interpolate(to: floatn10, t: 0.75), -5)
    }
    
    func testPointInterpolate() {
        XCTAssertEqual(point0_0.interpolate(to: point10_10, t: 0.5), .init(x: 5, y: 5))
        XCTAssertEqual(point10_10.interpolate(to: point0_0, t: 0.5), .init(x: 5, y: 5))
        XCTAssertEqual(point10_10.interpolate(to: point10_n10, t: 0.5), .init(x: 10, y: 0))
        XCTAssertEqual(point0_0.interpolate(to: point10_10, t: 0.1), .init(x: 1, y: 1))
        XCTAssertEqual(point10_10.interpolate(to: point0_0, t: 0.1), .init(x: 9, y: 9))
    }
    
    func testMultiPointInterpolatDivisions() {
        let div1 = point0_0.interpolate(to: point10_10, divisions: 10)
        XCTAssertEqual(div1.count, 10)
        let div2 = point10_10.interpolate(to: point0_0, divisions: 10)
        XCTAssertEqual(Array(div1.dropFirst().reversed()), Array(div2.dropFirst()))
        let div3 = point10_10.interpolate(to: point0_0, divisions: 5)
        XCTAssertEqual(div3[2], CGPoint(x: 6, y: 6))
    }
    
    func testMoveTowardsByDistance() {
        let distance = point0_0.distanceTo(point10_10)
        let p1 = point0_0.move(distance: distance * 0.5, alongVectorFormedByOtherPoint: point10_10)
        let p2 = point10_10.move(distance: distance * 0.5, alongVectorFormedByOtherPoint: point0_0)
        XCTAssertEqual(distance, 14.142135623730951)
        XCTAssertEqual(p1.x, point5_5.x, accuracy: 0.0001)
        XCTAssertEqual(p1.y, point5_5.y, accuracy: 0.0001)
        XCTAssertEqual(p2.x, point5_5.x, accuracy: 0.0001)
        XCTAssertEqual(p2.y, point5_5.y, accuracy: 0.0001)
    }
    
    func testSlopeIntercept1() {
        let p1 = CGPoint(x: 0, y: 1)
        let p2 = CGPoint(x: 1, y: 3)
        let (slope, intercept) = p1.slopeIntercept(for: p2)
        XCTAssertEqual(slope, 2)
        XCTAssertEqual(intercept, 1)
    }

    func testSlopeIntercept2() {
        let p1 = CGPoint(x: 0, y: 1)
        let p2 = CGPoint(x: 1, y: 0)
        let (slope, intercept) = p1.slopeIntercept(for: p2)
        XCTAssertEqual(slope, -1)
        XCTAssertEqual(intercept, 1)
    }
    
    func testSlopeIntercept3() {
        let pM3M5 = CGPoint(x: -3, y: -5)
        let pM2M3 = CGPoint(x: -2, y: -3)
        let pM1M1 = CGPoint(x: -1, y: -1)
        let pP1P3 = CGPoint(x: 1, y: 3)
        let pP2P5 = CGPoint(x: 2, y: 5)
        let pP4P5 = CGPoint(x: 4, y: 5)
        let a = pM3M5.slopeIntercept(for: pM2M3)
        let b = pP2P5.slopeIntercept(for: pM1M1)
        let c = pM1M1.slopeIntercept(for: pM2M3)
        let d = pP1P3.slopeIntercept(for: pM2M3)
        let e = pM1M1.slopeIntercept(for: pP2P5)
        let x = pM1M1.slopeIntercept(for: pP4P5)
        XCTAssertEqual(a.slope, b.slope, accuracy: 0.000001)
        XCTAssertEqual(b.slope, c.slope, accuracy: 0.000001)
        XCTAssertEqual(c.slope, d.slope, accuracy: 0.000001)
        XCTAssertEqual(d.slope, e.slope, accuracy: 0.000001)
        XCTAssertNotEqual(e.slope, x.slope, accuracy: 0.000001)
        XCTAssertEqual(a.yIntercept, b.yIntercept, accuracy: 0.000001)
        XCTAssertEqual(b.yIntercept, c.yIntercept, accuracy: 0.000001)
        XCTAssertEqual(c.yIntercept, d.yIntercept, accuracy: 0.000001)
        XCTAssertEqual(d.yIntercept, e.yIntercept, accuracy: 0.000001)
        XCTAssertNotEqual(e.yIntercept, x.yIntercept, accuracy: 0.000001)
        
        let val3:Double = 3
        let val3A = pM3M5.slopeIntercept(for: pM2M3, calculatingYforX: val3)
        let val3B = a.slope * val3 + a.yIntercept
        XCTAssertEqual(val3A, val3B)
    }
    
    func testClamp() {
        XCTAssertEqual(CGFloat(-1).clamped(), 0)
        XCTAssertEqual(CGFloat(1).clamped(), 1)
        XCTAssertEqual(Double(10).clamped(), 1)
        XCTAssertEqual(CGFloat(0.43).clamped(), 0.43)
        
        XCTAssertEqual(CGPoint(x: 10, y: 0.5).clamped(), CGPoint(x: 1, y: 0.5))
        XCTAssertEqual(CGPoint(x: -10, y: 0.5).clamped(), CGPoint(x: 0, y: 0.5))
        XCTAssertEqual(CGPoint(x: 0.5, y: 10).clamped(), CGPoint(x: 0.5, y: 1))
        XCTAssertEqual(CGPoint(x: 0.5, y: -10).clamped(), CGPoint(x: 0.5, y: 0))
        XCTAssertEqual(CGPoint(x: 0.5, y: 0.5).clamped(), CGPoint(x: 0.5, y: 0.5))
        
        XCTAssertEqual(Int(-10).clamped(), 0)
        XCTAssertEqual(Int(10).clamped(), 1)
    }
    
    func testValueMap() {
        XCTAssertEqual(Double(10).mapToNormal(sourceRange: 0...100), 0.1, accuracy: 0.0000001)
        XCTAssertEqual(Double(100).mapToNormal(sourceRange: 0...100), 1, accuracy: 0.0000001)
        XCTAssertEqual(Double(1000).mapToNormal(sourceRange: 0...100), 10, accuracy: 0.0000001)
        XCTAssertEqual(Double(25).mapIn(sourceRange: 0...50, toTargetRange: 0...100), 50, accuracy: 0.0000001)
        XCTAssertEqual(CGFloat(25).mapIn(sourceRange: 0...50, toTargetRange: 0...100), 50, accuracy: 0.0000001)
        XCTAssertEqual(CGPoint(x: 50, y: 25).mapIn(sourceRange: 0...50, toTargetRange: 0...100), CGPoint(x: 100, y: 50))
        XCTAssertEqual(CGPoint(x: 80, y: 120).mapIn(sourceRect: .init(x: 50, y: 100, width: 150, height: 200), toTargetRect: .init(x: 0, y: 0, width: 100, height: 100)), CGPoint(x: 20, y: 10))
        XCTAssertEqual(CGPoint(x: 5, y: 10).mapToNormal(sourceSize: .init(width: 20, height: 100)), CGPoint(x: 0.25, y: 0.1))
        XCTAssertEqual(CGPoint(x: 0.5, y: 0.2).map(keyPath: \.y, { $0.invertInNormalRange() }), CGPoint(x: 0.5, y: 0.8))
        XCTAssertEqual(CGPoint(x: 0.8, y: 0.2).map(keyPath: \.x, { $0.invertInNormalRange() }).x, CGPoint(x: 0.2, y: 0.7).x, accuracy: 0.0001)
        XCTAssertEqual(CGPoint(x: 0.8, y: 0.2).map(keyPath: \.x, { $0.invertInNormalRange() }).y, CGPoint(x: 0.2, y: 0.2).y)
        XCTAssertEqual(
            CGPoint(x: 250, y: 0.0).map(keyPath: \.x, { $0.invert(sourceRange: 0...1000) }).x,
            CGPoint(x: 750, y: 0.0).x,
            accuracy: 0.0001)
        XCTAssertEqual(
            CGPoint(x: 750, y: 0.0).map(keyPath: \.x, { $0.invert(sourceRange: 0...1000) }).x,
            CGPoint(x: 250, y: 0.0).x,
            accuracy: 0.0001)
        XCTAssertEqual(
            CGPoint(x: 750, y: 10.0).map(keyPath: \.x, { $0.invert(sourceRange: 0...1000) }).y,
            CGPoint(x: 250, y: 10.0).y,
            accuracy: 0.0001)
    }
    
    func testIntToFloat() {
        let intA:Int = 5
        let floatA:CGFloat = 5
        let intB:Int = 6
        let floatB:Double = 6
        let intC:Int = 7
        XCTAssertEqual(intA.float(), floatA)
        XCTAssertEqual(intB.float(), floatB)
        XCTAssertNotEqual(intC.float(), floatA)
    }

    func testNthRoot() {
        XCTAssertEqual(9.nthRoot(n: 2), 3)
        XCTAssertEqual(-9.nthRoot(n: 2), -3)
        XCTAssertEqual(4.nthRoot(n: 2), 2)
        XCTAssertEqual(27.nthRoot(n: 3), 3)
        XCTAssertEqual(6561.nthRoot(n: 4), 9)
        XCTAssertNotEqual(50.nthRoot(n: 2), 3)
    }
    
    func testIntBit() {
        XCTAssertEqual(Int(UInt8.max), bit16ToBit8(Int(UInt16.max)))
    }
    
    func testNormalisation() {
        XCTAssertEqual(CGPoint(x: 10, y: 10).normalize(in: CGSize(width: 100, height: 100)), CGPoint(x: 0.1, y: 0.1))
    }
}



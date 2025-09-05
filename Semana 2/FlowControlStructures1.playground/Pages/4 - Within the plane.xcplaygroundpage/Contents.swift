//: [Previous](@previous)

/*:
 - Important:
⚠️ **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
 Using the Cartesian plane reference, use a switch-case expression to apply the following rules:
    - Assign to `location` the quadrant number in which the coordinate lies, using the format: `"1"`, `"2"`, `"3"`, or `"4"`.
    - If the coordinate lies on an axis, assign to `location` the corresponding axis using the format: `x=2.3` or `y=-1`, depending on the axis.
    - If the coordinate is located at the origin, assign to `location` the value: `"origin"`.
    - If the coordinate is outside the boundaries shown in the image, assign to `location`: `"out of bounds"`.
 
 ![Imagine a plane >:v](plane.png)
 */

import Foundation
import XCTest

class Tests: XCTestCase {
    func test_exerciseTests() {
        XCTAssertEqual(WithinThePlane(coordinate: (0.001, 2)).location, "1")
        XCTAssertEqual(WithinThePlane(coordinate: (-3.1, 5.0)).location, "2")
        XCTAssertEqual(WithinThePlane(coordinate: (-1.0, -1.2)).location, "3")
        XCTAssertEqual(WithinThePlane(coordinate: (2, -4.0)).location, "4")
        XCTAssertEqual(WithinThePlane(coordinate: (0.00000, 0.0000)).location, "origin")
        XCTAssertEqual(WithinThePlane(coordinate: (-218, 0.2)).location, "out of bounds")
        //XCTAssertEqual(WithinThePlane(coordinate: (0.001, 2)).location, "x=3.9")
        //XCTAssertEqual(WithinThePlane(coordinate: (0.001, 2)).location, "y=-5.0")
    }
}


struct WithinThePlane {
    
    var location: String = ""
    
    init(coordinate: (Double, Double)) {
        let (x, y) = coordinate
        switch (x, y) {
        case (0, 0):
            location = "origin"
        case let (x, y) where abs(x) > 5 || abs(y) > 5:
            location = "out of bounds"
        case let (x, y) where x == 0:
            location = "y=\(y)"
        case let (x, y) where y == 0:
            location = "x=\(x)"
        case let (x, y) where x > 0 && y > 0:
            location = "1"
        case let (x, y) where x < 0 && y > 0:
            location = "2"
        case let (x, y) where x < 0 && y < 0:
            location = "3"
        case let (x, y) where x > 0 && y < 0:
            location = "4"
        default:
            location = "out of bounds"
        }
    }
}
Tests.defaultTestSuite.run()

//: [Next](@next)

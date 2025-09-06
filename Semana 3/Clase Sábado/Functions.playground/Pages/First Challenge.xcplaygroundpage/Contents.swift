
/*:
 - Important:
⚠️ **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
 Refactor the greetByMiddleName(fromFullName:) to check whether the middle name is longer than 10 characters and return the greeting. If it is, then greet the person with their first name, their middle initial (the first letter of the middle name followed by a period), and their last name instead.
 \
 \
    **Example:** Alois Rumpelstiltskin Chaz -> Hey, Alois R. Chaz
 */

import Foundation
import XCTest

class Tests: XCTestCase {
    func test_exerciseTests() {
        XCTAssertEqual(greetByMiddleName(fromFullName: (first: "Alejandro", middle: nil, last: "Mendoza")), "Hey there!")
        XCTAssertEqual(greetByMiddleName(fromFullName: (first: "Alois", middle: "Rumpelstiltskin", last: "Chaz")), "Hey, Alois R. Chaz")
    }
    
    private func greetByMiddleName(fromFullName name: (first: String, middle: String?, last: String)) -> String {
        guard let middleName = name.middle else {
            return "Hey there!"
        }
        if middleName.count > 10 {
            return "Hey, \(name.first) \(middleName.prefix(1)). \(name.last)"
        }else{
            return "Hey, \(name.first) \(middleName) \(name.last)"
        }
    }
}
Tests.defaultTestSuite.run()

//: [Next](@next)

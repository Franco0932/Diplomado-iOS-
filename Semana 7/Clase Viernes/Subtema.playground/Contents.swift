import UIKit
import XCTest

class AritmeticExpressionTest: XCTest{
    func test_ShouldAddTwoNumbers(){
        let expression = AritmeticExpression.add(.digit(2), .digit(3))
        
        let result = try! AritmeticExpression.evaluate(expression)
        
        XCTAssertEqual(result, 5)
    }
    
    func test_ShouldThrowErrorWhenDivisonByZero() {
        let expression = AritmeticExpression.divide(.digit(8), .digit(0))
        let expression2 = AritmeticExpression.divide(.digit(0), .add(.digit(-2), .digit(2)))
        
        XCTAssertThrowsError(try AritmeticExpression.evaluate(expression))
        XCTAssertThrowsError(try AritmeticExpression.evaluate(expression2))

    }
}

indirect enum AritmeticExpression{ //Enum recursivo con indirect
    case digit (Double)
    case add(_ lhs: AritmeticExpression, _ rhs: AritmeticExpression)
    case divide(_ lhs: AritmeticExpression, _ rhs: AritmeticExpression)

    
    static func evaluate(_ expression: AritmeticExpression) -> Double {
        switch expression{
        case let .digit(value): return value
        case let .add(left, rigth): return evaluate(left) + evaluate(rigth)
        case let .divide(left, rigth): return evaluate(left) + evaluate(rigth)
        }
    }
}


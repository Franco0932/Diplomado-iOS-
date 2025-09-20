i
let something: [String] = []
let something2 = [String]()
let something3: Array<String> = []
let somthing4: Array<Int> = []

// Stack
// first in, last out

struct StackIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        return items.removeLast()
    }
    
    func map<U>(_ transformer: (Element) -> (U)) -> [U] {
        var result = [U]()
        
        for item in items {
            result.append(transformer(item))
        }
        
        return result
    }
    
    
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<Element> {
            return StackIterator(stack: self)
        }
}



var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)

var myStackIterator = StackIterator(stack: intStack)

//while let value = myStackIterator.next() {
//    print("got: \(value)")
//}

for value in intStack {
    print("\(value)")
}

//print(intStack.pop())
//print(intStack.pop())
//print(intStack.pop())

//var stringStack = Stack<String>()
var stringStack = Stack(items: ["test"])
//stringStack.push(1)
stringStack.push("test 2")

//print(stringStack.pop())
//print(stringStack.pop())
//print(stringStack.pop())


// Generic Methods and Functions
//// Map
//func myMap<T, U>(items: [T], _ transformer: (T) -> (U)) -> [U] {
//    var result = [U]()
//    
//    for item in items {
//        result.append(transformer(item))
//    }
//    
//    return result
//}
//
//let strings: [String] = ["one", "two", "three"]
//
//let stringsLengths = myMap(items: strings) { string in
//    return string.count
//    }
//
//print(stringsLengths)

//func checkIfEqual<T: CustomStringConvertible, U: CustomStringConvertible>(_ first: T, _ second: U) -> Bool {
//    return first.description == second.description
//}
//
//checkIfEqual(1, 2)
//checkIfEqual(Int(1), UInt(1))
//checkIfEqual(Float(1.0), Double(1.0))





// Protocols no tienen genéricos
// associatedType


//protocol IteratorProtocol {
//    associatedtype Element
//    mutating func next() -> Element?
//}

//protocol Sequence {
//    associatedtype Iterator: IteratorProtocol 
//    associatedtype Element where Element == Iterator.Element 
//    func makeIterator() -> Iterator
//}

// Tipos opacos








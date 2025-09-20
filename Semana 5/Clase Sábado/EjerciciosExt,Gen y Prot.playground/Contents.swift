import UIKit

//# Protocol, Extension and Generics Exercises
//
//## Protocol Challenges
//
//### First Challenge
//The `printTable(_:)` function has a bug: It crashes if any of the data items are longer than the label of their column.
//Try changing the age of a person to _1,000_ to see this happen. Fix the bug.
//
//> [!NOTE]
//> Your solution will likely result in incorrect table formatting; that is fine for now. You will fix the formatting in the third challenge, below.

//let data = [
//    ["Eva", "30", "6"],
//    ["Salem", "40", "18"],
//    ["Andres", "50", "20"]
//]

//let headers = [
//    "Emplyee name",
//    "Age",
//    "Years of experience"
//]

protocol TabularDataSource {
    var numberOfRow: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    func itemForRow(row: Int, column: Int) -> String
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department: TabularDataSource {
    var numberOfRow: Int { people.count }
    
    var numberOfColumns: Int { 3 }
    
    func label(forColumn column: Int) -> String {
        let label: String
        
        switch column {
        case 0: label = "Employee name"
        case 1: label = "Age"
        case 2: label = "Years of experience"
        default: fatalError("A department should only have 3 columns")
        }
        
        return label
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        let person = people[row]
        let item: String
        
        switch column {
        case 0: item = person.name
        case 1: item = "🙊\(person.age)"
        case 2: item = "\(person.yearsOfExperience)"
        default: fatalError("Invalid row: \(row), column: \(column) combination")
        }
        
        return item
    }
    
    let name: String
    var people: [Person] = []
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
}



var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 1000, yearsOfExperience: 6))
department.add(Person(name: "Salem", age: 40, yearsOfExperience: 8))
department.add(Person(name: "Andres", age: 50, yearsOfExperience: 10))

//func printTable(_ dataSource: TabularDataSource) {
//    var headerRow = "|"
//    var columnWidths = [Int]()
//    
//    for columnIndex in 0..<dataSource.numberOfColumns {
//        let columnLabel = dataSource.label(forColumn: columnIndex)
//        let columnHeader = " \(columnLabel) |"
//        headerRow += columnHeader
//        columnWidths.append(columnHeader.count)
//    }
//    
//    print(headerRow)
//    
//    for rowIndex in 0..<dataSource.numberOfRow {
//        var output = "|"
//        for rowColumnIndex in 0..<dataSource.numberOfColumns {
//            let item = dataSource.itemForRow(row: rowIndex, column: rowColumnIndex)
//            let paddingNeeded = columnWidths[rowColumnIndex] - item.count - 2
//            let safePadding = max(0, paddingNeeded)
//            let padding = String(repeating: " ", count: safePadding)
//            output += " \(item)\(padding)|"
//        }
//        print(output)
//    }
//}

func printTable(_ dataSource: TabularDataSource) {
    var headerRow = "|"
    var columnWidths = [Int]()

    for columnIndex in 0..<dataSource.numberOfColumns {
        var maxWidth = dataSource.label(forColumn: columnIndex).count
        for rowIndex in 0..<dataSource.numberOfRow {
            let item = dataSource.itemForRow(row: rowIndex, column: columnIndex)
            maxWidth = max(maxWidth, item.count)
        }
        columnWidths.append(maxWidth)
    }
    
    for columnIndex in 0..<dataSource.numberOfColumns {
        let label = dataSource.label(forColumn: columnIndex)
        let padding = String(repeating: " ", count: columnWidths[columnIndex] - label.count)
        headerRow += " \(label)\(padding) |"
    }
    
    print(headerRow)


    for rowIndex in 0..<dataSource.numberOfRow {
        var row = "|"
        for columnIndex in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemForRow(row: rowIndex, column: columnIndex)
            let padding = String(repeating: " ", count: columnWidths[columnIndex] - item.count)
            row += " \(item)\(padding) |"
        }
        print(row)
    }
}


printTable(department)
print("----------------------------------------------\n")


//
//### Second Challenge
//Create a new type, `BookCollection`, that conforms to `TabularDataSource`.
//Calling printTable(_:) on a book collection should show a table of books with columns for _titles_, _authors_, and _average reviews_.
//
//> [!Note]
//> Unless all the books you use have very short titles and author names, you will need to have completed the previous challenge!

struct Book {
    let title: String
    let author: String
    let averageReviews: Double
}

struct BookCollection: TabularDataSource {
    let name: String
    private(set) var books: [Book] = []
    
    init(name: String) { self.name = name }
    mutating func add(_ book: Book) { books.append(book) }
    
    var numberOfRow: Int { books.count }
    var numberOfColumns: Int { 3 }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Title"
        case 1: return "Author"
        case 2: return "Average Reviews"
        default: fatalError("The Book Collection should only have 3 columns")
        }
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        let book = books[row]
        switch column {
        case 0: return book.title
        case 1: return book.author
        case 2: return String(format: "%.1f", book.averageReviews)
        default: fatalError("Invalid row: \(row), column: \(column) combination")
        }
    }
}

var collection = BookCollection(name:"Library")
collection.add(Book(title: "It", author: "Stephen King", averageReviews: 4.5))
collection.add(Book(title: "Harry Potter", author: "J.K. Rowling", averageReviews: 4.7))
collection.add(Book(title: "La Divina Comedia", author: "Dante Alighieri", averageReviews: 4.2))

printTable(collection)

print("-------------------------------------------------------\n")

//### Third Challenge (optional)
//After you fixed the crashing bug in the first challenge, the table rows and columns were likely misaligned.
//Fix your solution to correctly align the table rows and columns. Verify that your solution does not crash with values longer than their column labels.
//
//-----------------------------------------------------------------------------------------
//



//## Extension Challenges
//
//### First Challenge
//You made the `Department` type conform to the `CustomStringConvertible` protocol. Refactor your playground from that chapter to move `CustomStringConvertible` conformance into an extension.
//


extension Department: CustomStringConvertible {
    var description: String {
        return "Department -  name: \(name) - people: \(people.count)"
    }
}

print(department,"\n")

//extension Department: CustomStringConvertible {
//    var description: String {
//        var result = "Department: \(name)\n"
//        result += "People (\(people.count)):\n"
//        for person in people {
//            result += "- \(person.name), age: \(person.age), experience: \(person.yearsOfExperience) years\n"
//        }
//        return result
//    }
//}


//### Second Challenge
//Extend the `Array` type to add a method `secondElement()` that returns the second element of the array if it exists, or `nil` if the array has fewer than two elements. Additionally, add a computed property `isNotEmpty` that returns `true` if the array is not empty, and `false` otherwise.
//
//```swift
//// usage example
let numbers = [1, 2, 3, 4]
if let second = numbers.secondElement() {
    print("The second element is \(second)")
} else {
    print("The array does not have a second element")
}
//// The second element is 2
//
let emptyArray: [Int] = []
print("Is the array not empty? \(emptyArray.isNotEmpty)\n")
//// Is the array not empty? false
//```

extension Array {
    func secondElement() -> Element? {
        count >= 2 ? self[1] : nil
    }
    var isNotEmpty: Bool { !isEmpty }
}

//### Third Challenge
//Give the `Int` type a nested `enum` with cases **even** and **odd**.
//Also give `Int` a property of that type to correctly report whether an integer is even or odd.
//
//```swift
let myInt = 2
print(myInt.evenOrOdd) // even
print(7.evenOrOdd) // odd

//extension Int {
//    enum ImpPar {
//        case even
//        case odd
//    }
//    var evenOrOdd: ImpPar { self % 2 == 0 ? .even : .odd }
//}


//```
//
//### Fourth Challenge (optional)
//Update the `Int` a nested `enum` with cases **even** and **odd** to conform to `CustomStringConvertible` so it has a custom print description.
//Make the protocol conformance of the enum in an extension
//
//```swift
//let myInt = 2
//print(myInt.evenOrOdd) // Hey, I'm an even number
//print(7.evenOrOdd) // Oh no, I'm an odd number
//```
//-----------------------------------------------------------------------------------------

extension Int {
    enum ImpPar {
        case even
        case odd
    }

    var evenOrOdd: ImpPar {
        self % 2 == 0 ? .even : .odd
    }
}

extension Int.ImpPar: CustomStringConvertible {
    var description: String {
        switch self {
        case .even: return "Hey, I'm an even number"
        case .odd: return "Hey, I'm an even number"
        }
    }
}


//
//## Generic Challenges
//
//### First Challenge
//Create a generic `Pair` structure that holds two elements of any type (they can be different types). Implement a method to swap the two elements.
//
//```swift
//// usage example
var myPair = Pair(first: "Hello", second: 1)

print(myPair) // Pair: Hello, 1
let swapped = myPair.swapped()
print(swapped) // Pair: 1, Hello

struct Pair<First, Second>: CustomStringConvertible {
    var first: First
    var second: Second

    func swapped() -> Pair<Second, First> {
        Pair<Second, First>(first: second, second: first)
    }

    var description: String { "Pair: \(first), \(second)" }
}

print("----------------------------------------\n")


//### Second Challenge
//Add a `filter(_:)` method to your `Stack` structure. It should take a single argument, a closure that takes an `Element` and returns a `Bool`, and return a new `Stack<Element>` that contains any elements for which the closure returns true.
//
struct Stack<Element>: CustomStringConvertible {
    private var storage: [Element] = []

    init() {}
    init(_ items: [Element]) { self.storage = items }

    mutating func push(_ item: Element) { storage.append(item) }
    @discardableResult mutating func pop() -> Element? { storage.popLast() }

    func filter(_ include: (Element) -> Bool) -> Stack<Element> {
        var result = Stack<Element>()
        for item in storage where include(item) {
            result.push(item)
        }
        return result
    }

    var description: String { "Stack(\(storage))" }
}

var s = Stack([1, 2, 3, 4, 5, 6])
let pares = s.filter { $0 % 2 == 0 }
print(pares)
print("----------------------------------------\n")

//### Third Challenge
//Write a generic function called `findAll(_:_:)` that takes an array of any type `T` that conforms to the `Equatable` protocol and a single element (also of type `T`).
//`findAll(_:_:)` should return an array of integers corresponding to every location where the element was found in the array. For example, `findAll([5,3,7,3,9], 3)` should return `[1,3]` because the item 3 exists at indices 1 and 3 in the array. Try your function with both integers and strings.
//

func findAll<T: Equatable>(_ array: [T], _ value: T) -> [Int] {
    var indices: [Int] = []
    for (index, element) in array.enumerated() {
        if element == value {
            indices.append(index)
        }
    }
    return indices
}

print(findAll([5, 3, 7, 3, 9], 3))

//### Fourth Challenge
//Write an extension for the `Dictionary` type that adds a method `mapValuesToArray(_:)`. This method should take a closure that transforms the values of the dictionary and return an array of the transformed values.
//```swift
//// usage example


//### Fifth Challenge
//Create a protocol `ComparableItem` that requires conforming types to implement a method `isSmallerThan(_ other: Self) -> Bool`. Then, create a generic function `sortedItems<T: ComparableItem>(_: [T]) -> [T]` that sorts an array of `ComparableItem` items using the `isSmallerThan` method.
//```swift
//// usage example
//let people = [
//    Person(name: "Alice", age: 30),
//    Person(name: "Bob", age: 25),
//    Person(name: "Charlie", age: 35)
//]
//
//let sortedPeople = sortItems(people)
//for person in sortedPeople {
//    print("\(person.name): \(person.age)")
//}
//// Output:
//// Bob: 25
//// Alice: 30
//// Charlie: 35
//
//let products = [
//    Product(name: "Laptop", price: 999.99),
//    Product(name: "Smartphone", price: 699.99),
//    Product(name: "Tablet", price: 499.99)
//]
//
//let sortedProducts = sortItems(products)
//for product in sortedProducts {
//    print("\(product.name): \(product.price)")
//}
//}
// Output:
// Tablet: 499.99
// Smartphone: 699.99
// Laptop: 999.99
//```
//
//### Sixth Challenge (optional)
//Modify the `findAll(_:_:)` function you wrote for the third challenge to accept a generic `Collection` instead of an array.
//> [!NOTE]
//> You will need to change the return type from [Int] to an array of an associated type of the Collection protocol.

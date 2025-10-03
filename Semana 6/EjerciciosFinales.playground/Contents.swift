import UIKit

//First challenge
//Create a function that receives an enumerator as a parameter with the following
//options: .addition, .subtraction, .multiplication, .division and an array of numbers. Return
//the result after applying the selected operation to all numbers. Handle division by zero
//with Result or throws.
//Example:
//operation(.addition, numbers: [1,2,3,4]) // 10
//operation(.division, numbers: [20, 5, 0]) // error: division by zero

enum operacion{
    case addition
    case substraction
    case multiplication
    case division
}

enum errorDiv: Error{
    case divisionByZero(mensaje: String)
}

func operationSel(_ operation: operacion, numbers: [Double]) throws -> Double {
    guard let a = numbers.first else{
        return 0
    }
    
    let b = numbers.dropFirst()
    
    switch operation {
    case .addition:
        return b.reduce(a, +)
    case .substraction:
        return b.reduce(a, -)
    case .multiplication:
        return b.reduce(a, *)
    case .division:
        guard !b.contains(0) else {
            throw errorDiv.divisionByZero(mensaje: "Error: División entre 0")
        }
        return b.reduce(a, /)
    }
}

do{
    let Ejemplo1 = try operationSel(.addition, numbers: [1,2,3,4])
    print(Ejemplo1)
    let Ejemplo12 = try operationSel(.division, numbers: [20, 5, 0])
    print(Ejemplo12)
}catch errorDiv.divisionByZero(let mensaje){
    print("\(mensaje)")
}

print("____________________________________________________________\n")

//Second challenge
//Create a function that receives an array of integers and returns a dictionary with the
//count of positive, negative and zero values.
//Example:
//checkNumbers([-3, 0, 2, 5, -1]) // ["positives": 2, "negatives": 2, “zeros":1]

func checkNumbers(_ numbers: [Int]) -> [String: Int] {
    var counts = ["positives": 0, "negatives": 0, "zeros": 0]

    for number in numbers {
        if number > 0 {
            counts["positives"]! += 1
        } else if number < 0 {
            counts["negatives"]! += 1
        } else {
            counts["zeros"]! += 1
        }
    }
    return counts
}

let Ejemplo2 = checkNumbers([-3, 0, 2, 5, -1])
print(Ejemplo2)

print("____________________________________________________________\n")


//Third challenge
//Create a function that receives an integer and a limit number. Return an array of Strings
//with the multiplication table of the given number up to the limit.
//Example:
//multiply(number: 7, limit: 12) //
//["7x1=7",
//“7x2=14",
//…,
//“7x12=84”]

func multli(number: Int, limit: Int) -> [String]{
    var table: [String] = []
    for i in 1...limit{
        let result = "\(number) * \(i) = \(number * i)"
        table.append(result)
    }
    return table
}

let Ejemplo3 = multli(number: 7, limit: 12)
print(Ejemplo3)

print("____________________________________________________________\n")


//Fourth challenge
//Make a function that receives a string that simulates a password and returns an enum
//PasswordStrength: .weak, .medium, .strong depending on rules: - Minimum 6
//characters - Contains a capital letter - Contains a number - Contains a point - Bonus:
//contains a special symbol (!, @, #, etc.).
//Example:
//checkPassword("Pass123.") // .medium
//checkPassword("Strong#Pass1.") // .strong

 enum PasswordStrength {
     case weak
     case medium
     case strong
 }

 func checkPassword(_ password: String) -> PasswordStrength {
     var strength = 0
     let speCharacters = CharacterSet(charactersIn: "!@#$%^&*.,()")

     if password.count >= 6 { strength += 1 }
     if password.contains(where: {$0.isUppercase}) {strength += 1}
     if password.contains(where: {$0.isNumber}) {strength += 1}
     if password.rangeOfCharacter(from: speCharacters) != nil { strength += 1 }

     if strength >= 4 {
         return .strong
     } else if strength >= 2 {
         return .medium
     } else {
         return .weak
     }
 }

print("Contraseña: Pass123. -> \(checkPassword("Pass123."))")
print("Contraseña: Strong#Pass1. -> \(checkPassword("Strong#Pass1."))")
print("Contraseña: Hola123 -> \(checkPassword("Hola123"))")
print("Contraseña: fi -> \(checkPassword("fi"))")
print("____________________________________________________________\n")


//Fifth challenge
//Make a function that receives an array of optional strings and returns all the non-nil
//values in a new array. If all values are nil, return a message: "All values are empty”.
//Example:
//let texts: [String?] = ["Hello", nil, "World"]
//filterOptionals(texts) // ["Hello", “World"]
    

func filterOptionals(_ array: [String?]) -> [String] {
    var nonNilValues: [String] = []

    for i in array {
        if let uString = i {
            nonNilValues.append(uString) //Si no es nil, lo añade al arreglo
        }
    }

    if nonNilValues.isEmpty {
        print("All values are empty")
    }

    return nonNilValues
}

let texts: [String?] = ["Hello", nil, "World"]
print(filterOptionals(texts)) // ["Hello", “World"]
print("____________________________________________________________\n")


//Sixth challenge
//Given an optional string, print "It's empty! You ripped me off!" when it's nil, "Thanks for
//my cat Schrödinger!" if input is "😺 " and "This ain't a cat!" when none of the others
//Example:
//receiveBox(with: “😺 ") // "Thanks for my cat Schrödinger!"
//receiveBox(with: nil) // "It's empty! You ripped me off!"
//receiveBox(with: “lol") // "This ain't a cat!”

func receiveBox(_ Scro: String?){
    switch Scro{
    case nil:
        print("It's empty! You ripped me off!")
    case "😸":
        print("Thanks for my cat Schrödinger!")
    default:
        print("This ain't a cat!")
    }
}

receiveBox("😸")
receiveBox(nil)
receiveBox("lol")

print("____________________________________________________________\n")


//Seventh challenge
//Create a function that simulates a simple bank account system.
//Requirements:
//Define a struct BankAccount with:
//•owner: String
//•balance: Double
//Add methods:
//•deposit(amount: Double) → increases the balance.
//•withdraw(amount: Double) → decreases the balance, but only if there are
//sufficient funds. Otherwise, print "Insufficient funds”.
//•transfer(amount: Double, to otherAccount: inout BankAccount) → transfers
//money to another account if balance is enough.
//Example:
//var account1 = BankAccount(owner: "Alice", balance: 1000)
//var account2 = BankAccount(owner: "Bob", balance: 500)
//account1.withdraw(amount: 200) // balance = 800
//account1.transfer(amount: 300, to: &account2)
//// account1.balance = 500
//// account2.balance = 800


struct BankAccount{
    let owner: String
    var balance: Double
    
    mutating func deposit(ammount: Double){
        if ammount > 0{
            balance += ammount
        }
    }
    
    mutating func withdraw(ammount: Double){
        if ammount > 0 && balance >= ammount{
            balance -= ammount
        }else{
            print("Insufficient funds")
        }
    }
    
    mutating func transfer(ammount: Double, to otherAccount: inout BankAccount){
        if ammount > 0 && balance >= ammount {
            balance -= ammount
            otherAccount.deposit(ammount: ammount)
        }else{
            print("Insufficient funds")
        }
    }
}

var account1 = BankAccount(owner: "Alice", balance: 1000)
var account2 = BankAccount(owner: "Bob", balance: 500)
account1.withdraw(ammount: 200) // balance = 800
account1.transfer(ammount: 300, to: &account2)
print(account1)
print(account2)
account1.deposit(ammount: 1000)
print(account1)
print("____________________________________________________________\n")


//Eight challenge
//Implement the Sieve of Eratosthenes algorithm in Swift from the provided unit tests.
//Return and print the resulting array containing only the prime numbers within the range.
//• The only parameter is the max number.
//• 0 and 1 are not prime numbers.
//• The next available number is marked as prime but the next multiples up to the max
//number are not.
//• Find the next prime number and repeat the previous step until reaching max number.
//Example:
//PrimeCalculator.calculate(upTo: 10) // [2,3,5,7]
//PrimeCalculator.calculate(upTo: 50) // [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
//PrimeCalculator.calculate(upTo: 85)
//// [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83]

struct PrimeCalculator {
    static func calculate(upTo max: Int) -> [Int]{
        guard max >= 2 else {return []}
        
        var prime = [Bool] (repeating: true, count: max + 1) //se marcan cuales son primos y cuales no
        prime[0] = false
        prime[1] = false
        
        for number in 2...Int(sqrt(Double(max))){
            if prime[number]{
                for multiple in stride(from: number * number, through: max, by: number){ //Se usa para iterar de manera eficiente
                    prime[multiple] = false
                }
            }
        }
        
        let primes = (2...max).filter { prime[$0]}
        return primes
    }
}

print(PrimeCalculator.calculate(upTo: 10)) // [2,3,5,7]
print(PrimeCalculator.calculate(upTo: 50)) // [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
print(PrimeCalculator.calculate(upTo: 100))

print("____________________________________________________________\n")


//Ninth challenge
//Given an array of people, find the youngest, the oldest and the difference in age
//between them, and return their respective ages and the age difference.
//struct Person {
//let name: String
//let age: Int
//}
//let son = Person(name: "Juan", age: 19)
//let daughter = Person(name: "Maria", age: 12)
//let mother = Person(name: "Benita", age: 60)
//let father = Person(name: "Camilo", age: 58)
//let family = [daughter, son, mother, daughter]
//Example:
//findAgeDifference(for: family) // (oldest: 60, youngest: 12, ageDifference: 48)

struct Person {
    let name: String
    let age: Int
}

func findAgeDifference(_ people: [Person]) -> (oldest: Int, youngest: Int, ageDifference: Int)? { //funcion con  tuplas
     guard !people.isEmpty else { return nil }

     let oldestPerson = people.max { $0.age < $1.age }! //Closures para comprar edades
     let youngestPerson = people.min { $0.age < $1.age }!
     let ageDifference = oldestPerson.age - youngestPerson.age

     return (oldestPerson.age, youngestPerson.age, ageDifference)
 }

let son = Person(name: "Juan", age: 19)
let daughter = Person(name: "Maria", age: 12)
let mother = Person(name: "Benita", age: 60)
let father = Person(name: "Camilo", age: 58)
let family = [daughter, son, mother, daughter]
print(findAgeDifference(family) ?? (0, 0, 0)) // (oldest: 60, youngest: 12, ageDifference: 48)



print("____________________________________________________________\n")

//Tenth challenge
//Write a closure that takes an array of optional strings and returns a new string that is the
//concatenation of all the strings in the array. Remember to use the methods map, filter
//and reduce to find the solution.
//Example:
//let someStrings: [String?] = ["This", "is", nil, "not", nil, "a", "drill", nil, “!"]
//// This is not a drill!


let concaOptionalStrings: ([String?]) -> String = { optionalStrings in optionalStrings
        .map {$0 ?? ""} //Transforma el arreglo de [String?] a [String]
        .filter {!$0.isEmpty} //Eliminamos string vacios
        .reduce("") {$0 + " " + $1} //concatenamos
        .trimmingCharacters(in: .whitespaces)
}

let someStrings: [String?] = ["This", "is", nil, "not", nil, "a", "drill", nil, "!"]
let eje10 = concaOptionalStrings(someStrings)
print(eje10)
                            
 


 

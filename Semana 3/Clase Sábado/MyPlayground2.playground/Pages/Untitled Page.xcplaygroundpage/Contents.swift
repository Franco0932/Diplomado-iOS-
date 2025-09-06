import UIKit

var optionalString: String? = "Chocolate"

print(optionalString)


guard let unwrappedString = optionalString else { fatalError() }
if let unwrappedByIf = optionalString {
    print(unwrappedByIf)
} else {
    print("no choco")
}

print(unwrappedString)

optionalString = nil

//print(optionalString!) // crash

if optionalString == nil {
    print("no choco")
} else {
    print(optionalString!)
}

optionalString = nil
let count = optionalString?.count
print(count)

let lowercaseString = optionalString?.lowercased()
print(lowercaseString)

optionalString?.append(contentsOf: " is my favourite game")
print(optionalString)

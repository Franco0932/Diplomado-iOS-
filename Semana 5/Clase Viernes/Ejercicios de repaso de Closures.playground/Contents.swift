import UIKit

let myArray = [1,2,3,4,5,6]
let transformArray = myArray.map ({
    return "\($0)"
})

print(transformArray)

let filterArray = myArray.filter { value in
        return value % 2 == 0
}
print(filterArray)

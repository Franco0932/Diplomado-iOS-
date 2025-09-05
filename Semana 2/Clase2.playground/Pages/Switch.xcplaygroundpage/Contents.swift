import Foundation

var animal = "dog"
let emoji = switch animal{
case "dog": "🐶"
case "cat": "🐈"
case "mouse": "🐁"
case "bird": "🦅"
default: "😉"
}

print(emoji)

switch animal{
case "dog", "cat", "mouse", "bird": print("Mascota común")
default: "😉"
}

let grade = 9.8
switch grade{
case ...5: print("Failed")
case 6..<9: print("Passed")
case 10...: print("Genius")
case 9: print("Nine is great")
default: print("Amazing")
}


//MARK: Tuplas y switch
var color = (255, 255, 255)
switch color {
case (_, _, 255): print("Max Blue")
case (_, 255, _): print("Max Green")
case (255, _, _): print("Max Red")
case (255, 255, 255): print("White")
default: break
}

// value binding and where clause
color = (255, 166, 35)
switch color {
case let (255, g, b) where g < 255 && b < 255: print("max red with green \(g) and blue \(b)")
case (let r, let g, 255) where g < 255 && r < 255: print("Max blue with red:\(r) and green:\(g)")
case let (255, g, b) where g < 255 && b < 255: print("Max blue with blue:\(b) and green:\(g)")
case (255, 255, 255): print("white")
default: print("random color")
}


//let point = (-50, 0)
//    if case let (x, 0) = point, x < 0{
//        print("X Axis, nagative")
//    }
//
//let point = (-50, 0)
//    guard case let (x, 0) = point, x < 0 else{
//        print("X Axis, nagative")
//    }

let point = (-50, 0)

if case let (x, 0) = point, x < 0 {
    print("X axis, negative")
} 

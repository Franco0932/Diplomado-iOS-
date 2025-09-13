import Foundation

enum TrafficLigth {
    case red
    case yellow
    case green
}

let currentLigth = TrafficLigth.yellow
let anotherLigth: TrafficLigth = .red

switch currentLigth {
case .green: print("green")
case .red: print("red")
case .yellow: print("yellow")

}

enum animalType: String {
    case ani
}

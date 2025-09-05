import Foundation

var moneyAvailable = 100_000

while moneyAvailable > 0{
    let amount = 1000 * Int.random(in: 1...10)
    print("Purchase at store A for: $\(amount.formatted())")
    moneyAvailable -= amount
    print("Amount left: $\(moneyAvailable.formatted())")
}

repeat {
    let amount = 1000 * Int.random(in: 1...10)
    print("Purchase at store B for: $\(amount.formatted())")
    moneyAvailable -= amount
}while moneyAvailable > 0


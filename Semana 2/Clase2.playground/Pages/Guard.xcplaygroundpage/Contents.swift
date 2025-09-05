import UIKit

var moneyAvailable: Float = 600
let bridgeToll: Float = 60
let tunnelToll: Float = 50
let gasPrice: Float = 525.40

//fill gas tank
guard moneyAvailable >= gasPrice else {
    fatalError("No te puedes mover, estas varado")
}

moneyAvailable -= gasPrice

//bridge
guard moneyAvailable >= bridgeToll else{
    fatalError("No puedes pasar por el puente")
}

moneyAvailable -= bridgeToll

//Tunnel
guard moneyAvailable >= tunnelToll else{
    fatalError("No puedes pasar por el tunel")
}

moneyAvailable -= tunnelToll

print("Legaste a tu destino, dinero disponible: \(moneyAvailable)")

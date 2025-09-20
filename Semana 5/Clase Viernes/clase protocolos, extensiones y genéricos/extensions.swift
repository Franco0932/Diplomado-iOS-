
let myValue: Double = 5

extension Double {
    var squared: Double { self * self }
}

print(myValue.squared)
// extender funcionalidad de un tipo de dato al que no tenemos acceso 


struct Car {
    private let maker: String    
    let model: String    
    let year: Int    
    var fuelLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0, "New value must be between 0 and 1")
        }
    }
}

// Protocol comformance
extension Car: CustomStringConvertible {
    var description: String {
        return "car: \(maker) - \(model)"
    }
}

// Add initializers
extension Car {
    init(maker: String, model: String, year: Int) {
            self.maker = maker    
            self.model  = model    
            self.year = year 
            self.fuelLevel =   1 
        }
}

// Nested Types
extension Car {
    enum Era {
        case vingage, modern
    }
}

// Methods
extension Car {
    mutating func emptyFuel(by amount: Double) {
        fuelLevel -= amount
    }
}


let firstCar = Car(maker: "Honda", 
                   model: "Civic", 
                   year: 2017, 
                   fuelLevel: 1.0)

print(firstCar)




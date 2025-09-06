import Foundation

//MARK: Estructuras
/*
 Parecidas a las clases y para propósito general
 */

struct workoutA {
    let dateAndTime: Date //Opcional
    
    func summary () -> String {
        return ""
    }
}

let firstWorkout = workoutA(dateAndTime: .now)

struct workoutB{
    let date: Date = Date()
}

let workoutB = workoutB()

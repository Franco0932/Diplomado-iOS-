//: [Previous](@previous)

import Foundation

let enrollStudents = 0
enrollStudents > 0 ? print("Las clases inician en Agosto 22") : print("Las clase fue cancelada este semestre") //> 0 ? (Ejecucuoin para verdadero) : (Ejecucion para falso)

if enrollStudents > 0{
    
}else{
    
}

let maxContentHeight = 120
let includeHeader = false
 
let rowHeight = includeHeader ? maxContentHeight + 50 : maxContentHeight //
let rowHeightIf = if includeHeader {
    maxContentHeight + 50
}else{
    maxContentHeight
}

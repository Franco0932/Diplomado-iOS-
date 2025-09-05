import UIKit

//MARK: Operadores de rango
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count

for name in names[2...] {
    print(name)
}
print("---------")
for name in names[...2] {
    print(name)
}

print("-----If Else------")
//MARK: Condicionales
//MARK: IF-ELSE
var mascota: String = "dog"
if mascota == "dog" {
    print("🐶")
}

if mascota == "dog" && mascota == "cat"{
    print("Alone in the world was a little catdog 🎶")
}

mascota = "rata"
if mascota == "dog" || mascota == "cat"{
    print("Una mascota común")
}

if mascota == "dog" {
    print("🐶")
}else{
    print("Algún animal random")
}

if mascota == "dog" {
    print("🐶")
}else if mascota == "cat" {
    print("🐈")
}else{
    print("Lol")
}

let age: Int = 18
mascota = "cat"

if age >= 18 && (mascota == "dog" || mascota == "cat") { //Se pueden o no ocupar los parentesis
    print("Puede adoptar")
}

let petType = if mascota == "dog"{
    "canino"
}else if mascota == "cat"{
    "felino"
}else{
    "otro"
}

if #available(iOS 26, *){
    //Some liquid glass thing
}else{
    //Fallback for older OS versions
}

if #unavailable(iOS 26){
    //Support to previous OS versions
}



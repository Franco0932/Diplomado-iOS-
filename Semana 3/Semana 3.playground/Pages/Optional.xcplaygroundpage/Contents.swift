import Foundation

func greetEveryone(){
    print("Hello There")
    
}

greetEveryone()

func introduceSomeone(name: String, age: Int){
    if age < 18{
        print("Youngster", name)
    }else{
        print("This is", name)
    }
}

introduceSomeone(name: "Franco", age: 24)

func add(_ rhs: Int = 2, plus lhs: Int = 2){
    rhs + lhs
}

//add(rhs: 2, lhs: 3)
add(2, plus: 3)
add()

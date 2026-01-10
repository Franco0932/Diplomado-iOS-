import UIKit

let queue = DispatchQueue(label: "Serial.queue")
print("Starting...")

queue.sync {
    print("Starting first task on queue")
    for i in 0...2 {
        sleep(2)
    }
    print("Finished first task in queue")
}

print ("Halfway Trough")

queue.sync {
    print("Starting first task on queue")
    for i in 0...2 {
        sleep(2)
    }
    print("Finished task 2 in queue")
}

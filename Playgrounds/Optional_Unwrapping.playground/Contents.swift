import UIKit

var optionalNumber: Int?
//optionalNumber = 23

// IF LET

if let number = optionalNumber {
    print("I have a value, it is \(number)")
} else {
    print("I do not have a value, I am nil")
}

// GUARD

func tripleNumber(number: Int?) {
    guard let number = number else {
        print("Exiting Function")
        return
    }
    
    print("My tripled number is \(number * 3)")
}

tripleNumber(number: optionalNumber)

// FORCE UNWRAPPING

//let forcedNumber = optionalNumber!

// OPTIONAL CHAINING

struct Device {
    var type: String
    var price: Float
    var color: String
}

var myPhone: Device?
myPhone = Device(type: "iPhone XS", price: 1149.00, color: "Space Gray")

let devicePrice = myPhone?.price

if let devicePrice = devicePrice {
    print("My total price = \(devicePrice * 1.07)")
}

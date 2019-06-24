import UIKit

struct Device {
    let type: String
    let price: Float
    let color: String
    
    init(type: String, price: Float, color: String) {
        self.type = type
        self.price = price
        self.color = color
    }
}

let macBookPro = Device(type: "MacBook Pro", price: 2799.00, color: "Space Gray")
let iMacPro = Device(type: "iMac Pro", price: 4999.00, color: "Space Gray")
let macPro = Device(type: "Mac Pro", price: 5999.00, color: "Silver")
let proDisplayXDR = Device(type: "Pro Display XDR", price: 4999.00, color: "Silver")
let proDisplayStand = Device(type: "Pro Display Stand", price: 999.00, color: "Silver")
let iPhoneXR = Device(type: "iPhone XR", price: 749.00, color: "Black")
let iPhoneXS = Device(type: "iPhone XS", price: 999.00, color: "Space Gray")
let iPadPro = Device(type: "iPad Pro", price: 999.00, color: "Space Gray")
let appleWatch = Device(type: "Apple Watch", price: 699.00, color: "Space Black")
let appleTV = Device(type: "Apple TV 4K", price: 199.00, color: "Black")

let devices = [macBookPro, iMacPro, macPro, proDisplayXDR, proDisplayStand, iPhoneXR, iPhoneXS, iPadPro, appleWatch, appleTV]

// FILTER

//let macs = devices.filter { (device) -> Bool in
//    device.type.contains("Mac")
//}
let macs = devices.filter({ return $0.type.contains("Mac") })

// MAP

let canadianPrices: [Float] = devices.map({ return $0.price * 1.3193 })

// REDUCE
let totalCanadianPrice = canadianPrices.reduce(0.0, +)
print(totalCanadianPrice)

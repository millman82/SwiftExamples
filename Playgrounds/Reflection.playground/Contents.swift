import Foundation

class Person {
    let id: Int64
    let firstName: String
    let lastName: String
    let age: Int
    
    init(id: Int64, firstName: String, lastName: String, age: Int)
    {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

extension Mirror {
    static func buildDictionary<T>(of: T) -> [String: Any] {
        let mirror = Mirror(reflecting: of)
        
        let props = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })
        
        return props
    }
}

let samplePerson = Person(id: 1, firstName: "First", lastName: "Last", age: 30)

let propDict = Mirror.buildDictionary(of: samplePerson)

for prop in propDict {
    print("key: \(prop.key) value: \(prop.value)")
}

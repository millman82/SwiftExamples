import UIKit

@propertyWrapper
struct Clamping<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>
    
    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        self.value = wrappedValue
        self.range = range
    }
    
    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
    
    // Optionally implement property projectedValue to get the wrapper itself
    var projectedValue: Clamping<Value> {
        get { return self }
    }
}

struct Solution {
    @Clamping(0...14) var pH: Double = 7.0
}

var solution = Solution(pH: 7.0)
solution.pH = -1
print(solution.pH)
// Access the wrapper property
print(solution.$pH)


// MARK: -- Trimming Wrapper
@propertyWrapper
struct Trimmed {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

struct Post {
    @Trimmed var title: String
    @Trimmed var body: String
}

var post = Post(title: "  Swift Property Wrappers  ", body: "...")
print(post.title)
post.title = "     @propertyWrapper      "
print(post.title)

// MARK: -- Data Versioning

@propertyWrapper
struct Versioned<Value> {
    private var value: Value
    private(set) var timestampedValues: [(Date, Value)] = []
    
    var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            timestampedValues.append((Date(), value))
        }
    }
    
    init(wrappedValue: Value) {
        self.value = wrappedValue
        self.wrappedValue = wrappedValue
    }
}

class ExpenseReport {
    enum State { case submitted, received, approved, denied }
    
    @Versioned var state: State = .submitted
}

// MARK: -- User Defaults

// One method of using user defaults could be by extension
extension UserDefaults {
    public enum Keys {
        static let hasSeenAppIntroduction = "has_seen_app_introduction"
    }
    
    // Indicates whether or not the user has seen the on-boarding
    var hasSeenAppIntroduction: Bool {
        set {
            set(newValue, forKey: Keys.hasSeenAppIntroduction)
        }
        get {
            return bool(forKey: Keys.hasSeenAppIntroduction)
        }
    }
}

// Another method is with a property wrapper
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsConfig {
    @UserDefault("has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}

UserDefaultsConfig.hasSeenAppIntroduction = false
print(UserDefaultsConfig.hasSeenAppIntroduction)
UserDefaultsConfig.hasSeenAppIntroduction = true
print(UserDefaultsConfig.hasSeenAppIntroduction)

// MARK: -- Used with functions

// MARK: Caching Pure Functions

@propertyWrapper
struct Cached<Input: Hashable, Output> {
    private var functionWithCache: (Input) -> Output
    
    init(wrappedValue: @escaping (Input) -> Output) {
        self.functionWithCache = Cached.addCachingLogic(to: wrappedValue)
    }
    
    var wrappedValue: (Input) -> Output {
        get { return self.functionWithCache }
        set { self.functionWithCache = Cached.addCachingLogic(to: newValue) }
    }
    
    private static func addCachingLogic(to function: @escaping (Input) -> Output) -> (Input) -> Output {
        var cache: [Input: Output] = [:]
        
        return { input in
            if let cachedOutput = cache[input] {
                return cachedOutput
            } else {
                let output = function(input)
                cache[input] = output
                return output
            }
        }
    }
}

struct Trigo {
    @Cached static var cachedCos = { (x: Double) in cos(x) }
}

Trigo.cachedCos(.pi * 2)
// Second run value is cached
Trigo.cachedCos(.pi * 2)

// Additional examples for property wrappers and functions
// @Delayed(delay: 0.3) and @Debounced(delay: 0.3), to deal with timing
// @ThreadSafe, to wrap a piece of code around a Lock

// MARK: -- HTTP GET

typealias Service<Response> = (_ completionHandler: @escaping (Result<Response, Error>) -> Void) -> ()

@propertyWrapper
struct GET {
    private var url: URL
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    var wrappedValue: Service<String> {
        get {
            return { completionHandler in
                let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
                    guard error == nil else { completionHandler(.failure(error!)); return }
                    
                    let string = String(data: data!, encoding: .utf8)!
                    
                    completionHandler(.success(string))
                }
                
                task.resume()
            }
        }
    }
}

struct API {
    @GET(url: "https://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=b6907d289e10d714a6e88b30761fae22")
    static var getCurrentWeather: Service<String>
}

API.getCurrentWeather { result in
    print(result)
}

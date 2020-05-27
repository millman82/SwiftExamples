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

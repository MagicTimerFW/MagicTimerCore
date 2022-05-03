
import Foundation

/// A type that represent counter behavior
public protocol MGCounterBehavior {
    /// The total counted vlaue
    var totalCountedValue: TimeInterval { get }
    /// The value that affect to totalCountedValue
    var effectiveValue: TimeInterval { get }
    /// The initial value of counter
    var defultValue: TimeInterval { get }
    /// Add effectiveValue to totalCountedValue
    func add()
    /// Subtract effectiveValue from totalCountedValue
    func subtract()
    /// Reset totalCountedValue to zero
    func resetTotalCounted()
    /// Set Value to totalCountedValue
    func setTotalCountedValue(_ value: TimeInterval)
    /// Set value to effectiveValue
    func setEffectiveValue(_ value: TimeInterval)
    /// Set value to defultValue
    func setDefaultValue(_ value: TimeInterval)
    /// Reset totalCountedValue to defultValue
    func resetToDefaultValue()
}

open class MGCounter: MGCounterBehavior {
    
    open var totalCountedValue: TimeInterval = 0
    open var effectiveValue: TimeInterval = 1.0
    open var defultValue: TimeInterval = 0.0 {
        willSet {
            totalCountedValue += newValue
        }
    }
    
    public init() { }
    
    open func add() {
        totalCountedValue += effectiveValue
    }
    
    open func subtract() {
        totalCountedValue -= effectiveValue
    }
    
    open func resetTotalCounted() {
        totalCountedValue = 0
    }
    
    open func setTotalCountedValue(_ value: TimeInterval) {
        self.totalCountedValue = value
    }
    
    open func setEffectiveValue(_ value: TimeInterval) {
        self.effectiveValue = value
    }
    
    open func setDefaultValue(_ value: TimeInterval) {
        self.defultValue = value
    }
    
    open func resetToDefaultValue() {
        totalCountedValue = defultValue
    }
}


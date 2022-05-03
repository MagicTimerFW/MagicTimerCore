import Foundation
import UIKit
import MagicTimerCommon

/// A type that every calculable object must conform
public protocol MGBackgroundCalculableBehavior {
    /// The timer fire date
    var timerFireDate: Date? { get }
    /// A Boolean value that determines whether the  is background mode active
    var isActiveBackgroundMode: Bool { get set }
    /// Calculate time diffrence between two date
    func calculateDateDiffrence() -> TimeInterval?
    /// Set timer firing date
    func setTimeFiredDate(_ value: Date)

    var backgroundTimeCalculateHandler: ((TimeInterval) -> Void)? { get set }
}

open class MGBackgroundCalculator: MGBackgroundCalculableBehavior {
    
    open var timerFireDate: Date?
    
    open var isActiveBackgroundMode: Bool = false

    open var backgroundTimeCalculateHandler: ((TimeInterval) -> Void)?
        
    public init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func willEnterForegroundNotification() {
        /// Check if background mode is active
        guard isActiveBackgroundMode else { return }
        
        /// Calculate time diffrence between two date
        if let timeInterval = calculateDateDiffrence() {
            backgroundTimeCalculateHandler?(timeInterval)
            
        }
    }
  
    /// Set nil value to timerFiredDate
    func invalidateFiredDate() {
        timerFireDate = nil
    }
    /// Calculate time diffrence between two date
    open func calculateDateDiffrence() -> TimeInterval? {
        guard timerFireDate != nil else { return nil }
        let validTimeSubtraction = abs(timerFireDate! - Date())
        return validTimeSubtraction.convertToTimeInterval()
        
    }
    /// Set timer firing date
    open func setTimeFiredDate(_ value: Date) {
        self.timerFireDate = value
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

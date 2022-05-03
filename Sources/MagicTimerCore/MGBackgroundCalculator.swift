import Foundation
import UIKit
import MagicTimerCommon

/// A type that every calculable object must conform
protocol MGBackgroundCalculableBehavior {
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

class MGBackgroundCalculator: MGBackgroundCalculableBehavior {
    
    public var timerFireDate: Date?
    
    public var isActiveBackgroundMode: Bool = false

    public var backgroundTimeCalculateHandler: ((TimeInterval) -> Void)?
        
    init() {
        
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
    public func calculateDateDiffrence() -> TimeInterval? {
        guard timerFireDate != nil else { return nil }
        let validTimeSubtraction = abs(timerFireDate! - Date())
        return validTimeSubtraction.convertToTimeInterval()
        
    }
    /// Set timer firing date
    public func setTimeFiredDate(_ value: Date) {
        self.timerFireDate = value
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

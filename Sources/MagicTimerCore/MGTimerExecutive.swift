

import Foundation

protocol MGExecutiveBehavior {
    /// A core timer of module.
    var scheduleTimer: Timer? { get }
    /// The timer time interval.
    var timeInerval: TimeInterval { get set }
    /// Create sheduleTImer and observe element in each timeInerval.
    func start(compeltion: (() -> Void)?)
    /// Invalidate the core timer.
    func suspand()
    
    var scheduleTimerHandler: (() -> Void)? { get set }
}

/**
 A type that manage core timer. For example starting or suspanding.
 */
class MGTimerExecutive: MGExecutiveBehavior {
    
    var scheduleTimerHandler: (() -> Void)?
    
    var scheduleTimer: Timer?
    
    var timeInerval: TimeInterval = 1.0
    
    var isTimerAlreadyStarted: Bool = false

    func start(compeltion: (() -> Void)?) {
        isTimerAlreadyStarted = true
        // Create instane of timer and assign to scheduleTimer
        scheduleTimer = Timer.scheduledTimer(withTimeInterval: timeInerval, repeats: true, block: { [weak self] _ in
            // Observe value every defined time interval
            self?.scheduleTimerHandler!()
            
        })
        // Add timer to custom Runloop
        RunLoop.main.add(scheduleTimer!, forMode: .common)
        
        guard compeltion != nil else { return }
        compeltion!()
    }
    
    func suspand() {
        // Invalidate core timer
        scheduleTimer?.invalidate()
        isTimerAlreadyStarted = false
    }

    
}

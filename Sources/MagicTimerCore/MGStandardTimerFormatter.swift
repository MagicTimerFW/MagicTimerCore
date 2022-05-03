
import Foundation

/// A type that any date formatter should conform
public protocol MGTimeFormatter {
    /// Convert time interval to String format
    /// - Parameter ti: elapsed time
    func converToValidFormat(ti: TimeInterval) -> String?
}

/// A type that contains time unit
enum MGTimeUnit: Int {
    /// A hour in seconds.
    case hour = 3600
    /// A minute  in seconds.
    case minute = 60
    /// A milliSeconds in seconds.
    case milliSeconds = 1000
}

open class MGStandardTimerFormatter: DateComponentsFormatter, MGTimeFormatter {
       
    override init() {
        super.init()
        unitsStyle = .positional
        zeroFormattingBehavior = .pad
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func converToValidFormat(ti: TimeInterval) -> String? {
        switch ti {
        case let x where Int(x) >= MGTimeUnit.hour.rawValue:
            allowedUnits = [.hour, .minute, .second]
        case let x where Int(x) <= MGTimeUnit.hour.rawValue:
            allowedUnits = [.minute, .second]
        default:
            break
        }
        return super.string(from: ti)
    }
}


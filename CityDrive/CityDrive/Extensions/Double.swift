import Foundation

extension Double {
    var costToString: String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".", with: ",") + " ₽"
    }

    func roundedToTwoDecimalPlaces() -> Double {
        let multiplier = pow(10.0, 2.0)
        return (self * multiplier).rounded() / multiplier
    }
}

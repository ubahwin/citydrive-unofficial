import Foundation

extension Int {
    var costToDouble: Double {
        return Double(self) / 100.0
    }

    var costToString: String {
        return self.costToDouble.costToString
    }
}

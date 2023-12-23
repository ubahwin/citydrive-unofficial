import Foundation

class Payback {
    private(set) var percent: Int = 20
    var amount: Double
    var peopleCount: Int

    var calculate: Double {
        return amount / Double(peopleCount) * (1.0 + (Double(percent) / (100.0 * Double(peopleCount))))
    }

    init(amount: Double = 1, peopleCount: Int = 2) {
        self.amount = amount
        self.peopleCount = peopleCount
    }

    func changePercent(_ newPercent: Int) {
        if 0 < newPercent && newPercent < 100 {
            self.percent = newPercent
        }
    }
}

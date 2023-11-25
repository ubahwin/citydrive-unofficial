import Foundation
import SwiftUI

struct CarNumber: Equatable {
    private let regexPattern = #"^(\w)(\d{3})(\w{2})(\d{2,3})"#

    let firstChar, numbers, lastChars, region: String

    var full: String {
        return firstChar + numbers + lastChars + region
    }

    init(number: String) {
        let regex = try? NSRegularExpression(pattern: regexPattern, options: [])
        let match = regex?.matches(
            in: number,
            options: [],
            range: NSRange(location: 0, length: number.utf16.count)
        ).first

        let firstChar = (number as NSString).substring(with: (match?.range(at: 1)) ?? NSRange())
        let numbers = (number as NSString).substring(with: (match?.range(at: 2)) ?? NSRange())
        let lastChars = (number as NSString).substring(with: (match?.range(at: 3)) ?? NSRange())
        let region = (number as NSString).substring(with: (match?.range(at: 4)) ?? NSRange())

        self.firstChar = firstChar.uppercased()
        self.numbers = numbers
        self.lastChars = lastChars.uppercased()
        self.region = region
    }
}

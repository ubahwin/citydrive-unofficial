import Foundation

struct Tariff {
    var usage, parking, transfer: Int
}

extension TariffResponse {
    var mapToTariff: Tariff {
        return Tariff(
            usage: self.usage?.price ?? 0,
            parking: self.parking?.price ?? 0,
            transfer: self.transfer?.price ?? 0
        )
    }
}

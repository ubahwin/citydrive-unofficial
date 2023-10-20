import Foundation

struct MiddleOrder {
    var locationStart, locationFinish: Location
    var details: MiddleDetails
}

struct MiddleDetails {
    var title, description: String
    var rows: [Row]
}

struct Row: Identifiable {
    var id: UUID
    var rowLeft, rowRight: Column
}

struct Column {
    var text: String
    var iconURL: String
    var color, fontStyle: String
}

struct Location {
    var timestamp, address: String
    var lat, lon: Double
}

extension MiddleOrderResponse {
    func mapToMiddleOrder() -> MiddleOrder {
        let rows = self.details?.rows?.compactMap { row in
            if
                let rowLeft = row.rowLeft,
                let rowRight = row.rowRight {
                return Row(id: UUID(),
                   rowLeft:
                    Column(
                        text: rowLeft.text ?? "",
                        iconURL: rowLeft.iconURL ?? "",
                        color: rowLeft.color ?? "",
                        fontStyle: rowLeft.fontStyle ?? ""),
                   rowRight:
                    Column(
                        text: rowRight.text ?? "",
                        iconURL: rowRight.iconURL ?? "",
                        color: rowRight.color ?? "",
                        fontStyle: rowRight.fontStyle ?? "")
                )
            }
            return nil
        }

        let order = MiddleOrder(
            locationStart: Location(
                timestamp: self.locationStart?.timestamp ?? "",
                address: self.locationStart?.address ?? "",
                lat: self.locationStart?.lat ?? 0,
                lon: self.locationStart?.lon ?? 0),
            locationFinish: Location(
                timestamp: self.locationFinish?.timestamp ?? "",
                address: self.locationFinish?.address ?? "",
                lat: self.locationFinish?.lat ?? 0,
                lon: self.locationFinish?.lon ?? 0),
            details: MiddleDetails(
                title: self.details?.title ?? "",
                description: self.details?.description ?? "",
                rows: rows ?? []
            )
        )

        return order
    }
}

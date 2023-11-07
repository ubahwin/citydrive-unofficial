import Foundation

struct GreenArea: Codable {
    var areas: [Area]
}

struct Area: Codable {
    var points: [Point]
}

extension GreenAreaResponse {
    func mapToGreenArea() -> GreenArea {
        let areas: [Area] = self.area?.compactMap { area in
            let points: [Point] = area.compactMap { point in
                return Point(
                    latitude: point.latitude ?? 0,
                    longitude: point.longitude ?? 0
                )
            }
            let area = Area(points: points)
            return area
        } ?? []

        return GreenArea(
            areas: areas
        )
    }
}

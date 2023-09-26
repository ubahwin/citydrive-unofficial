import Foundation

struct CarStatusResponse: Codable {
    let insuranceKasko, insuranceLife: Int?
    let selfieUpload, showDestinationPoint, selectedAllCars, mailruComboTariff: Bool?
    let directPassDefault, directPassAllowed: Bool?
    let preorderCars: [CarResponse]?
    let areaGroupDefaut: String?
    let discounts: DiscountsResponse?

    let cars: [CarResponse]?

    enum CodingKeys: String, CodingKey {
        case insuranceKasko = "insurance_kasko"
        case insuranceLife = "insurance_life"
        case selfieUpload = "selfie_upload"
        case showDestinationPoint = "show_destination_point"
        case selectedAllCars = "selected_all_cars"
        case mailruComboTariff = "mailru_combo_tariff"
        case directPassDefault = "direct_pass_default"
        case directPassAllowed = "direct_pass_allowed"
        case cars
        case preorderCars = "preorder_cars"
        case areaGroupDefaut = "area_group_defaut"
        case discounts
    }
}

struct CarResponse: Codable {
    let carID: String?
    let img: String?
    let model, number: String?
    let lat, lon: Double?
    let distance, walktime, fuel, tankVolume: Int?
    let powerReserve, tankVolumeEmergency, discount: Int?
    let transferable: Bool?
    let seats, remainPath: Int?
    let carFilterID: String?
    let notAvailable, horn, isElectric: Bool?
    let tariffID: String?
    let chargingLevel, remainPathElectric: Int?
    let areaGroupID: String?
    let engineWarnUpAvailable: Bool?
    let carFilterCompany: CarFilterCompanyResponse?
    let transferringIsAvailable, boosterSeat, babySeat, forSale: Bool?
    let eOsagoLink: String?
    let wrapBrand, fuelType: String?
    let inTransfer, hasTransponder, transferModeExists, engineWarnUp: Bool?
    let wrapBrandLogo: String?

    enum CodingKeys: String, CodingKey {
        case carID = "car_id"
        case img
        case model, number, lat, lon, distance, walktime, fuel
        case tankVolume = "tank_volume"
        case powerReserve = "power_reserve"
        case tankVolumeEmergency = "tank_volume_emergency"
        case discount, transferable, seats
        case remainPath = "remain_path"
        case carFilterID = "car_filter_id"
        case notAvailable = "not_available"
        case horn
        case isElectric = "is_electric"
        case tariffID = "tariff_id"
        case chargingLevel = "charging_level"
        case remainPathElectric = "remain_path_electric"
        case areaGroupID = "area_group_id"
        case engineWarnUpAvailable = "engine_warn_up_available"
        case carFilterCompany = "car_filter_company"
        case transferringIsAvailable = "transferring_is_available"
        case boosterSeat = "booster_seat"
        case babySeat = "baby_seat"
        case forSale = "for_sale"
        case eOsagoLink = "e_osago_link"
        case wrapBrand = "wrap_brand"
        case fuelType = "fuel_type"
        case inTransfer = "in_transfer"
        case hasTransponder = "has_transponder"
        case transferModeExists = "transfer_mode_exists"
        case engineWarnUp = "engine_warn_up"
        case wrapBrandLogo = "wrap_brand_logo"
    }
}

struct CarFilterCompanyResponse: Codable {
    let companyID, name, color: String?
    let cityOverlay: Bool?

    enum CodingKeys: String, CodingKey {
        case companyID = "company_id"
        case name, color
        case cityOverlay = "city_overlay"
    }
}

struct DiscountsResponse: Codable {
    let guaranteedApidoc: String?
    let guaranteed: Int?
    let potentialApidoc: String?
    let potential: Int?
    let appliedApidoc: String?
    let applied: Int?

    enum CodingKeys: String, CodingKey {
        case guaranteedApidoc = "guaranteed_apidoc"
        case guaranteed
        case potentialApidoc = "potential_apidoc"
        case potential
        case appliedApidoc = "applied_apidoc"
        case applied
    }
}

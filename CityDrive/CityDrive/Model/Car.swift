//
//  Car.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import Foundation
import MapKit

struct Car: Identifiable {
    var id: UUID
    
    var lat: Double
    var lon: Double
    
    var img: String
    var model: String
    var number: String

    var distance, walktime, fuel, tankVolume: Int
    var powerReserve, tankVolumeEmergency, discount: Int
    var transferable: Bool
    var seats, remainPath: Int
    var carFilterID: String
    var notAvailable, horn, isElectric: Bool
    var tariffID: String
    var chargingLevel, remainPathElectric: Int
    var areaGroupID: String
    var engineWarnUpAvailable: Bool
    var carFilterCompany: CarFilterCompany
    var transferringIsAvailable, boosterSeat, babySeat, forSale: Bool
    var eOsagoLink: String
    var wrapBrand, fuelType: String
    var inTransfer, hasTransponder, transferModeExists, engineWarnUp: Bool
    var wrapBrandLogo: String
}

struct CarFilterCompany {} 

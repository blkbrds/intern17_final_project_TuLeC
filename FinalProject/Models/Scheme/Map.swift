//
//  Map.swift
//  FinalProject
//
//  Created by tu.le2 on 01/09/2022.
//

import Foundation

final class Map {
    var geocodes: Geocodes?
    var location: Location?
    var name: String?

    init(json: JSObject) {
        self.geocodes = Geocodes(json: json["geocodes"] as? JSObject ?? ["": ""])
        self.location = Location(json: json["location"] as? JSObject ?? ["": ""])
        self.name = json["name"] as? String
    }
}

final class Geocodes {
    var latitude: Double
    var longitude: Double

    init(json: JSObject) {
        guard let main = json["main"] as? JSObject else {
            latitude = 0.0
            longitude = 0.0
            return
        }
        latitude = main["latitude"] as? Double ?? 0.0
        longitude = main["longitude"] as? Double ?? 0.0
    }
}

final class Location {
    var country: String?
    var crossStreet: String?
    var formattedAddress: String?
    var locality: String?
    var region: String?

    init(json: JSObject) {
        country = json["country"] as? String
        crossStreet = json["cross_street"] as? String
        formattedAddress = json["formatted_address"] as? String
        locality = json["locality"] as? String
        region = json["region"] as? String
    }
}

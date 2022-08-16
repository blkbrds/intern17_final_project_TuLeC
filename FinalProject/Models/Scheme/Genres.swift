//
//  Genres.swift
//  FinalProject
//
//  Created by tu.le2 on 10/08/2022.
//

import Foundation

class Genres {

    // MARK: - Properties
    var id: Int?
    var name: String?

    // MARK: - Initialize
    init(json: JSObject) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
    }
}

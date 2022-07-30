//
//  Slider.swift
//  FinalProject
//
//  Created by tu.le2 on 29/07/2022.
//

import Foundation
import UIKit

class Slider {
    var backdropPath: String?
    var id: Int?
    var originalTitle: String?
    var image: UIImage?

    init(json: JSObject) {
        self.backdropPath = json["backdrop_path"] as? String
        self.id = json["id"] as? Int
        self.originalTitle = json["original_title"] as? String
    }
}

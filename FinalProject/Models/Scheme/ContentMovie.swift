//
//  contentMovie.swift
//  FinalProject
//
//  Created by tu.le2 on 11/08/2022.
//

import Foundation
import UIKit

final class ContentMovie {
    var id: Int?
    var originalTitle: String?
    var backdropPath: String?
    var voteAverage: Double?
    var image: UIImage?

    init(json: JSObject) {
        self.backdropPath = json["backdrop_path"] as? String
        self.id = json["id"] as? Int
        self.originalTitle = json["original_title"] as? String
        self.voteAverage = json["vote_average"] as? Double
    }
}

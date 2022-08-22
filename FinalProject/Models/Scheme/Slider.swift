//
//  Slider.swift
//  FinalProject
//
//  Created by tu.le2 on 08/08/2022.
//

import Foundation
import UIKit

final class Slider {

    // MARK: - Properties
    var backdropPath: String?
    var id: Int?
    var originalTitle: String?
    var overview: String?
    var voteAverage: Double?
    var genres: [Int]?
    var image: UIImage?

    // MARK: - Initialize
    init(json: JSObject) {
        self.backdropPath = json["backdrop_path"] as? String
        self.id = json["id"] as? Int
        self.originalTitle = json["original_title"] as? String
        self.overview = json["overview"] as? String
        self.voteAverage = json["vote_average"] as? Double
        self.genres = json["genre_ids"] as? [Int]
    }
}

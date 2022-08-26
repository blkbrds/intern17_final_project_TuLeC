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
    var overview: String?
    var genres: [Int]?
    var image: UIImage?

    init(json: JSObject) {
        backdropPath = json["backdrop_path"] as? String
        id = json["id"] as? Int
        originalTitle = json["original_title"] as? String
        voteAverage = json["vote_average"] as? Double
        overview = json["overview"] as? String
        genres = json["genre_ids"] as? [Int]
    }
}

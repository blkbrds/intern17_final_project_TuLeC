//
//  contentMovie.swift
//  FinalProject
//
//  Created by tu.le2 on 11/08/2022.
//

import Foundation

class ContentMovie {
    var id: Int?
    var originalTitle: String?
    var voteAverage: Float?

    init(id: Int, originalTitle: String, voteAverage: Float) {
        self.id = id
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
    }
}

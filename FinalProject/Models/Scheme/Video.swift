//
//  Video.swift
//  FinalProject
//
//  Created by tu.le2 on 18/08/2022.
//

import Foundation

final class Video {
    var key: String?

    init(json: JSObject) {
        self.key = json["key"] as? String
    }
}

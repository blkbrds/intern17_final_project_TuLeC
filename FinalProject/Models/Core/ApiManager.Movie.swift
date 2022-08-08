//
//  ApiManager.Video.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

extension ApiManager.Movie {
    enum Path {
        case upComing
        case topRated
        case popular
        case nowPlaying
        case similar
        case videos
        case details
        case recommendations
    }

    static let moviePath: String = "\(ApiManager.Path.baseURL)\(ApiManager.Path.version)\(ApiManager.Path.moviePath)"

    static func getURL(type: Path, typePath: String, movieId: Int?) -> URL {
        var url: URL?
        switch type {
        case .popular, .topRated, .nowPlaying, .upComing:
            url = URL(string: ApiManager.Movie.moviePath + typePath)
        case .similar, .videos, .recommendations:
            url = URL(string: ApiManager.Movie.moviePath + "/\(String(describing: movieId))/" + typePath)
        case .details:
            url = URL(string: ApiManager.Movie.moviePath + "/\(String(describing: movieId))/")
        }

        guard let url = url else {
            return URL(fileURLWithPath: "")
        }

        return url.appending("api_key", value: ApiManager.Path.apiKey)
    }

    static func getSliderURL() -> URL {
        return getURL(type: .popular, typePath: ApiManager.Path.popular, movieId: nil)
    }

    static func getHomeApi(url: URL, completion: @escaping APICompletion) {
        ApiManager.shared.request(method: .get, with: url) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

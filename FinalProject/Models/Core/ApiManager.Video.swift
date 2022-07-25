//
//  ApiManager.Video.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

extension ApiManager.Video {

    static let moviePath: String = "\(ApiManager.Path.baseURL)\(ApiManager.Path.version)\(ApiManager.Path.moviePath)"
    static let searchPath: String = "\(ApiManager.Path.baseURL)\(ApiManager.Path.version)\(ApiManager.Path.searchPath)\(ApiManager.Path.moviePath)\(ApiManager.Path.apiKey)"

    struct QueryString {
        enum CustomPath {
            case movie
            case search
        }

        func defineAPI(type: CustomPath, path: String) -> String {
            switch type {
            case .movie:
                return moviePath + path + ApiManager.Path.apiKey
            case .search:
                return searchPath + path
            }
        }

        func getUpComing() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.upComing)
        }

        func getTopRated() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.topRated)
        }

        func getPopular() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.popular)
        }

        func getNowPlaying() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.nowPlaying)
        }

        func getLatest() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.latest)
        }

        func getVideos(movieID: String) -> String {
            return defineAPI(type: .movie, path: "/\(movieID)/videos")
        }

        func getDetails(movieID: String) -> String {
            return defineAPI(type: .movie, path: "/\(movieID)")
        }

        func getRecommendations(movieID: String) -> String {
            return defineAPI(type: .movie, path: "/\(movieID)/recommendations")
        }

        func searchMovies(query: String) -> String {
            return defineAPI(type: .search, path: "&query=\(query)")
        }

        func getImage(imagePath: String) -> String {
            return ApiManager.Path.imageURL +
            "/\(imagePath)"
        }
    }
}

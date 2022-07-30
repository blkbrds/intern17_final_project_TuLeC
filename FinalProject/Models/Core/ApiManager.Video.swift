//
//  ApiManager.Video.swift
//  FinalProject
//
//  Created by tu.le2 on 25/07/2022.
//

import Foundation

extension ApiManager.Video {

    enum TypeURL {
        case popular
        case nowPlaying
        case topRated
        case latest(movieId: String)
        case upComing
    }

    static let moviePath: String = "\(ApiManager.Path.baseURL)\(ApiManager.Path.version)\(ApiManager.Path.moviePath)"
    static let searchPath: String = "\(ApiManager.Path.baseURL)\(ApiManager.Path.version)\(ApiManager.Path.searchPath)\(ApiManager.Path.moviePath)\(ApiManager.Path.apiKey)"

    struct QueryString {
        enum CustomPath {
            case movie
            case search
        }

        static func defineAPI(type: CustomPath, path: String) -> String {
            switch type {
            case .movie:
                return moviePath + path + ApiManager.Path.apiKey
            case .search:
                return searchPath + path
            }
        }

        static func getUpComing() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.upComing)
        }

        static func getTopRated() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.topRated)
        }

        static func getPopular() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.popular)
        }

        static func getNowPlaying() -> String {
            return defineAPI(type: .movie, path: ApiManager.Path.nowPlaying)
        }

        static func getLatest(movieID: String) -> String {
            return defineAPI(type: .movie, path: "\(movieID)\(ApiManager.Path.similar)")
        }

        static func getVideos(movieID: String) -> String {
            return defineAPI(type: .movie, path: "/\(movieID)/videos")
        }

        static func getDetails(movieID: String) -> String {
            return defineAPI(type: .movie, path: "/\(movieID)")
        }

        static func getRecommendations(movieID: String) -> String {
            return defineAPI(type: .movie, path: "/\(movieID)/recommendations")
        }

        static func searchMovies(query: String) -> String {
            return defineAPI(type: .search, path: "&query=\(query)")
        }

        static func getImage(imagePath: String) -> String {
            return ApiManager.Path.imageURL +
            "/\(imagePath)"
        }
    }

    static func callHomeApi(type: TypeURL, completion: @escaping APICompletion) {
        var urlString: String?
        switch type {
        case .popular:
            urlString = ApiManager.Video.QueryString.getPopular()
        case .nowPlaying:
            urlString = ApiManager.Video.QueryString.getNowPlaying()
        case .topRated:
            urlString = ApiManager.Video.QueryString.getTopRated()
        case .latest(let movieId):
            urlString = ApiManager.Video.QueryString.getLatest(movieID: movieId)
        case .upComing:
            urlString = ApiManager.Video.QueryString.getUpComing()
        }

        guard let urlString = urlString else {
            return
        }

        ApiManager.shared.request(method: .get, with: urlString) { result in
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

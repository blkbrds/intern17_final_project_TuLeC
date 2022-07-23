//
//  ApiManager.Video.swift
//  FinalProject
//
//  Created by tu.le2 on 23/07/2022.
//

import Foundation

extension ApiManager.Video {
    struct QueryString {
        func getUpComing() -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            ApiManager.Path.upComing +
            ApiManager.Path.apiKey
        }

        func getTopRated() -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            ApiManager.Path.topRated +
            ApiManager.Path.apiKey
        }
        
        func getPopular() -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            ApiManager.Path.popular +
            ApiManager.Path.apiKey
        }
        
        func getNowPlaying() -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            ApiManager.Path.nowPlaying +
            ApiManager.Path.apiKey
        }
        
        func getLatest() -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            ApiManager.Path.latest +
            ApiManager.Path.apiKey
        }

        func getVideos(movieID: String) -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            "/\(movieID)/videos" +
            ApiManager.Path.apiKey
        }
        
        func getDetails(movieID: String) -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            "/\(movieID)" +
            ApiManager.Path.apiKey
        }
        
        func getRecommendations(movieID: String) -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.moviePath +
            "/\(movieID)/recommendations" +
            ApiManager.Path.apiKey
        }
        
        func searchMovies(query: String) -> String {
            return ApiManager.Path.baseURL +
            ApiManager.Path.version +
            ApiManager.Path.searchPath +
            ApiManager.Path.moviePath +
            ApiManager.Path.apiKey +
            "&query=\(query)"
        }
        
        func getImage(imagePath: String) -> String {
            return ApiManager.Path.imageURL +
            "/\(imagePath)"
        }
    }
}

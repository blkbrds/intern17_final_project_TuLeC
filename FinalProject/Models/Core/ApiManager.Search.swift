//
//  ApiManager.Search.swift
//  FinalProject
//
//  Created by tu.le2 on 08/08/2022.
//

import Foundation

extension ApiManager.Search {
    static let searchPath: String = ApiManager.Path.baseURL + ApiManager.Path.version + ApiManager.Path.searchPath + ApiManager.Path.moviePath
    
    static func getURL(query: String) -> URL{
        let url = URL(string: searchPath)
        guard let url = url else {
            return URL(fileURLWithPath: "")
        }
        
        return url.appending("api_key", value: ApiManager.Path.apiKey)
            .appending("query", value: query)
    }
}

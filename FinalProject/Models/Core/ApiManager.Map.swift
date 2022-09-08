//
//  ApiManager.Map.swift
//  FinalProject
//
//  Created by tu.le2 on 01/09/2022.
//

import Foundation

extension ApiManager.Map {
    static func getURL(query: String, near: String = "VietNam,DaNang") -> URL {
        let url = URL(string: ApiManager.Path.mapURL)
        guard let url = url else {
            return URL(fileURLWithPath: "")
        }
        return url.appending([
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "near", value: near),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "v", value: "20220701")
        ])
    }

    static func getMapApi(url: URL, completion: @escaping Completion<[Map]>) {
        ApiManager.shared.request(method: .get, with: url, author: .exist) { result in
            switch result {
            case .success(let data):
                var map: [Map] = []
                guard let data = data,
                      let items = data["results"] as? [JSObject] else {
                    completion(.failure(APIError.error("No data result")))
                    return
                }
                for item in items {
                    map.append(Map(json: item))
                }
                completion(.success(map))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

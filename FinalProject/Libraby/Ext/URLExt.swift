//
//  URLExt.swift
//  FinalProject
//
//  Created by tu.le2 on 08/08/2022.
//

import Foundation

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
}

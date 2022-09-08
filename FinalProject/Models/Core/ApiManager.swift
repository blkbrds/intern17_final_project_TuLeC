//
//  ApiManager.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import Foundation

typealias APICompletion = (APIResult) -> Void
typealias Completion<Value> = (Result<Value>) -> Void

enum Result<Value> {
    case success(Value)
    case failure(APIError)
}

enum APIResult {
    case success(JSObject?)
    case failure(APIError)
}

enum APIError: Error {

    case error(String)
    case errorURL
    case noInternet

    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        case .noInternet:
            return "No Internet"
        }
    }
}

enum Method: String {
    case get
    case post
}

enum Author {
    case exist
    case doesExist
}

final class ApiManager {

    static let shared: ApiManager = ApiManager()

    func request(method: Method,
                 with url: URL?,
                 author: Author = .doesExist,
                 completion: @escaping APICompletion) {
        // Check Interneet is available
        if !Reachability.isInternetAvailable() {
            completion(.failure(.noInternet))
        }

        // Check url is existed
        guard let url = url else {
            completion(.failure(.errorURL))
            return
        }

        // Create request
        let header: [String: String]? = [
            "Content-Type": "application/json;charset=UTF-8",
            "Authorization": "fsq3X+b7szAs1DHGqUhhfzY3Fa0SEgRx2eUVbDlzNads+jY="
        ]
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        switch author {
        case .exist:
            request.allHTTPHeaderFields = header
        case .doesExist:
            break
        }

        // Config
        let config = URLSessionConfiguration.ephemeral
        if #available(iOS 11.0, *) {
            config.waitsForConnectivity = true
        } else {
            // Fallback on earlier versions
        }

        // Session
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    completion(.success(data?.toJSON()))
                }
            }
        }

        task.resume()
    }
}

extension ApiManager {

    struct Path { }

    struct Movie { }

    struct Search { }

    struct Discover { }

    struct Genre { }

    struct Video { }

    struct Detail { }

    struct Map { }
}

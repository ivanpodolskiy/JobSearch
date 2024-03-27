//
//  NetworkingService.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import Foundation
import Combine

fileprivate enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Networking {
    func sendRequest<T: Decodable>(from url: URL, decdoingType: T.Type)  -> AnyPublisher<T, NetworkError>
}

class NetworkingService: Networking {
    func sendRequest<T>(from url: URL, decdoingType: T.Type) -> AnyPublisher<T, NetworkError> where T : Decodable {
        let urlRequest = compilelRequest(url: url, method: .get)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResonse = response as? HTTPURLResponse,  200..<300 ~= httpResonse.statusCode else { throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                print("Decoding error:", error)
                return NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
    private func compilelRequest(url: URL, method: HTTPMethod) -> URLRequest{
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

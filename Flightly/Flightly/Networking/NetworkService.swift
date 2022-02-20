//
//  Service.swift
//  Flightly
//
//  Created by Lenka Janosova on 20/02/2022.
//

import Foundation
import Combine

enum KiwiError: Error {
    case sessionFailed(error: URLError)
    case decodingFailed
    case other(Error)

    func message() -> String {
        switch self {
        case .sessionFailed(error: let urlError):
            return urlError.localizedDescription
        case .decodingFailed:
            return "Decoding failed error occured."
        case .other(let error):
            return error.localizedDescription
        }
    }
}

enum NetworkService {
    static func request<SomeDecodable: Decodable>(url: URL) -> AnyPublisher<SomeDecodable, KiwiError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: SomeDecodable.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return .decodingFailed
                case let urlError as URLError:
                    return .sessionFailed(error: urlError)
                default:
                    return .other(error)
                }
            }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

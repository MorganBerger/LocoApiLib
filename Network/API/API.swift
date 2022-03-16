//
//  API.swift
//  Loco API Test
//
//  Created by Morgan Berger on 02/03/2022.
//

import Foundation
import Combine

enum API {
    case getAllLocalisables
}

protocol NetworkManager {
    func request(_ api: API) -> AnyPublisher<LocoResponse, LocoApiError>
}

protocol TranslationManagerNetworking {
    func getAllLocalisables() -> AnyPublisher<LocoResponse, LocoApiError>
}

extension NetworkManagerImpl: TranslationManagerNetworking {
    func getAllLocalisables() -> AnyPublisher<LocoResponse, LocoApiError> {
        return request(.getAllLocalisables)
    }
}

struct NetworkManagerImpl: NetworkManager {
    
    private func createRequest(_ api: API) -> URLRequest? {
        let urlStr = AppConfig.network.baseURL + api.endpoint
        guard var urlComponents = URLComponents(string: urlStr) else {
            return nil
        }
        let queryItems = api.getParams.map { param in
            URLQueryItem(name: param.key, value: param.value)
        }
        urlComponents.queryItems = queryItems
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.cachePolicy = .reloadIgnoringCacheData
            api.headers.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            return request
        }
        return nil
    }
    
    private func fireRequest(_ request: URLRequest) -> AnyPublisher<LocoResponse, LocoApiError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw LocoApiError.noResponse
                }
                if !(200..<300 ~= response.statusCode) {
                    throw LocoApiError.httpError(statusCode: response.statusCode)
                }
                UserDefaultsManager.save(value: response.allHeaderFields["Last-Modified"], for: .lastModifiedResponseHeader)

                return output.data
            }
            .decode(type: LocoResponse.self, decoder: JSONDecoder())
            .mapError { error -> LocoApiError in
                if error is LocoApiError {
                    return error as! LocoApiError
                }
                print(error)
                return LocoApiError.other(error)
            }
            .eraseToAnyPublisher()
    }
    
    func request(_ api: API) -> AnyPublisher<LocoResponse, LocoApiError> {
        print("Requesting data at endpoint: \(api)...")
        guard let request = createRequest(api) else {
            return Fail(error: LocoApiError.urlNotValid(urlStr: api.endpoint)).eraseToAnyPublisher()
        }
        return fireRequest(request)
    }
}

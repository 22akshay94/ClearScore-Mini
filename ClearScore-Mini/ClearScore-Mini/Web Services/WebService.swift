//
//  File.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import Foundation

// A protocol defining a network call
protocol Network {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable
}

// An enum of different types of possible network errors
enum NetworkError: Error {
    case DecodingError
    case DomainError
    case NoConnectionError
    case NoError
    
    var localizedDescription: String {
        switch self {
        case .NoConnectionError:
            return NSLocalizedString(Constants.NetworkErrorMessages.NetworkError, comment: "NetworkError")
        case .DecodingError:
            return NSLocalizedString(Constants.NetworkErrorMessages.DecodingError, comment: "NetworkError")
        case .DomainError:
            return NSLocalizedString(Constants.NetworkErrorMessages.DomainError, comment: "NetworkError")
        case .NoError:
            return NSLocalizedString("", comment: "My error")
        }
    }
}

// An enum of different types of HTTP methods required to make an API call
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// The Resource struct represents all the information required to make create an API session (Assumption: Codable wasn't required for  the task but a prod level code could use this)
struct Resource<T: Decodable> {
    let url: URL
    var httpMethod: HTTPMethod = .get
}


// Webservice client
public class WebService<T: Decodable>: Network {
    
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        
        NetworkConnection().networkConnection { isReachable in
            if isReachable {
                var request = URLRequest(url: resource.url)
                request.httpMethod = resource.httpMethod.rawValue
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    guard let data = data, error == nil else {
                        completion(.failure(.DomainError))
                        return
                    }
                    let result = try? JSONDecoder().decode(T.self, from: data)
                    if let result = result {
                        completion(.success(result))
                    } else {
                        completion(.failure(.DecodingError))
                    }
                }.resume()
            } else {
                completion(.failure(.NoConnectionError))
            }
        }
    }
}


class MockWebService: Network {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
    }
}

//
//  MockWebservices.swift
//  ClearScore-MiniTests
//
//  Created by Akshay Yerneni on 25/01/2022.
//

import Foundation
@testable import ClearScore_Mini

class MockWebService<T: Decodable>: Network {
    
    var mockResponse = [String:Any]()
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        let json = mockResponse
        do {
            let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let data = data else {return}
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            print(error.localizedDescription)
            completion(.failure(.DecodingError))
        }
    }
}


struct TestConstants {
    
    struct MockURLs {
        static let FaultyURL = URL(string: "http://www.xyz-sample-test.com/invalid")!
    }
    
    struct MockJSON {
        
        static let CorrectResponse = ["creditReportInfo" :
                        [
                            "score" : 666,
                            "maxScoreValue": 700,
                            "minScoreValue" : 0,
                            "currentShortTermCreditLimit" : 3000,
                            "equifaxScoreBandDescription" : "Excellent",
                            "daysUntilNextReport": 1
                        ]
                    ]
        static let IncorrectResponse = ["creditReportInfo" :
                                    [
                                        "score" : 666,
                                        "maxScoreValue": 700,
                                        "minScoreValue" : 0,
                                        "currentShortTermCreditLimit" : "3000",
                                        "equifaxScoreBandDescription" : "Excellent",
                                        "daysUntilNextReport": 1
                                    ]
                                ]
    }
    
}

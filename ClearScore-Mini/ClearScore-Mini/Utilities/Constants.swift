//
//  Constants.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import Foundation

struct Constants {
    
    struct URLs {
        static let getCreditInfo = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")!
    }
}

typealias isReachable = (Bool) ->  ()
//typealias getCreditScoreCompletion = (Result<CreditScore, NetworkError>) -> ()

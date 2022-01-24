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
    
    struct NetworkErrorMessages {
        static let NetworkError = "There seems to be no internet connection. Please check the conenctivity and try again?"
        static let DecodingError = "Oops! We've seem to have run into a problem."
        static let DomainError = "Oops! We've seem to have run into a problem."
    }
}

typealias isReachable = (Bool) ->  ()

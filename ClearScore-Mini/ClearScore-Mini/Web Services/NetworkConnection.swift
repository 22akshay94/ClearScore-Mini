//
//  Reachability.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import Foundation
import Reachability

// Checks if any internet connection is available and returns a boolean based on it
class NetworkConnection {
    
    func networkConnection(completionHandler: @escaping isReachable) {
        let reachability = try? Reachability()
        if let reachability = reachability {
            if (reachability.connection == .unavailable) {
                completionHandler(false)
            } else {
                completionHandler(true)
            }
        }
    }
}

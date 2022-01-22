//
//  Storyboarded.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 22/01/2022.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(storyboard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(storyboard: String) -> Self {
        let storyboardID = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardID) as! Self
    }
}

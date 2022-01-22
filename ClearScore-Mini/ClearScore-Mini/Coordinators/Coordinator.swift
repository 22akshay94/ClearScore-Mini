//
//  Coordinator.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 22/01/2022.
//

import UIKit
import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navController: UINavigationController {get set}
    
    func start()
}

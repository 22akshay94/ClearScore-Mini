//
//  MainCoordinator.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 22/01/2022.
//

import UIKit
import Foundation

class MainCoordinator: Coordinator {
    
    var childCoordinators =  [Coordinator]()
    
    var navController: UINavigationController
    
    init(_ navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let home = HomeViewController.instantiate(storyboard: "Main")
        let resource = Resource<CreditScore>(url: Constants.URLs.getCreditInfo, httpMethod: .get)
        home.injectDependencies(CreditViewModel(resource, WebService<CreditScore>()))
        home.coordinator = self
        
        navController.pushViewController(home, animated: false)
    }
    
    func detailPage() {
        let detail = DetailViewController.instantiate(storyboard: "Main")
        detail.coordinator = self
        navController.pushViewController(detail, animated: true)
    }
}

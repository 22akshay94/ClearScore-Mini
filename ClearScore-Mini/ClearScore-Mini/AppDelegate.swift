//
//  AppDelegate.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let resource = Resource<CreditScore>(url: Constants.URLs.getCreditInfo, httpMethod: .get)
        
//        let home = HomeViewController<CreditScore>(CreditViewModel(resource, WebService<CreditScore>()))
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        home.injectDependencies(CreditViewModel(resource, WebService<CreditScore>()))
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: home)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}


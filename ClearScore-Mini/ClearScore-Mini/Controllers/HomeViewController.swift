//
//  ViewController.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var donutView: DonutView!
    @IBOutlet private weak var errorView: ErrorView!
    
    private var creditViewModel: Credit!
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // Function to inject dependencies
    func injectDependencies(_ viewModel: Credit) {
        creditViewModel = viewModel
    }
    
    // Setting up api call and donut view
    private func setup() {
        
        donutView.delegate = self
        errorView.delegate = self
        apiCall()
    }
    
    private func apiCall() {
        donutView.loader()
        creditViewModel.update = { [weak self] result in
            guard let self = self else {return}
            if result == .NoError {
                let creditInfo = self.creditViewModel.getCreditInfo()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.donutView.loader(show: false)
                    self.donutView.loadScore(creditInfo: creditInfo, duration: 2)
                }
            } else {
                DispatchQueue.main.async {
                    self.donutView.loader(show: false)
                    self.errorView.showError(with: result.localizedDescription)
                }
            }
        }
        creditViewModel.getCreditScore()
    }
}

// Donut view delegate tap gesture method
extension HomeViewController: DonutDelegate {
    
    func donutTapped() {
        coordinator?.detailPage()
    }
}

// Error view delegate refresh method
extension HomeViewController: ErrorViewDelegate {
    
    func refresh() {
        print("refresh pressed")
        NetworkConnection().networkConnection(completionHandler: { isReachable in
            if isReachable {
                DispatchQueue.main.async {
                    self.errorView.dismiss()
                    self.apiCall()
                }
            }
        })
    }
}

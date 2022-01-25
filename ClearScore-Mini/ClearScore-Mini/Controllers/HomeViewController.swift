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
        NetworkConnection().networkConnection { [weak self] isReachable in
            guard let self = self else {return}
            if isReachable {
                self.creditViewModel.update = { result in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.donutView.loader(show: false)
                        if result == .NoError {
                            let creditInfo = self.creditViewModel.getCreditInfo()
                            self.donutView.loadScore(creditInfo: creditInfo, duration: 2)
                        } else {
                            self.errorView.showError(with: result.localizedDescription)
                        }
                    }
                }
                self.creditViewModel.getCreditScore()
            } else {
                DispatchQueue.main.async {
                    self.donutView.loader(show: false)
                    self.errorView.showError(with: NetworkError.NoConnectionError.localizedDescription)
                }
            }
        }
    }
}

// Donut view delegate tap gesture method
extension HomeViewController: DonutDelegate {
    
    func donutTapped() {
        coordinator?.detailPage(creditViewModel.getCreditInfo())
    }
}

// Error view delegate refresh method
extension HomeViewController: ErrorViewDelegate {
    
    func refresh() {
        NetworkConnection().networkConnection(completionHandler: { [weak self] isReachable in
            guard let self = self else {return}
            if isReachable {
                DispatchQueue.main.async {
                    self.errorView.dismiss()
                    self.apiCall()
                }
            }
        })
    }
}

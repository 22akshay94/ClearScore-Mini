//
//  ViewController.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    private var creditViewModel: Credit!
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditViewModel.update = { [weak self] success in
            guard let self = self else {return}
            switch success {
            case .NoError:
                print(self.creditViewModel.getCreditInfo())
            case.NetworkError:
                print("Please try again with network")
            case .DecodingError:
                print("Something wrong with the data model")
            case .DomainError:
                print("Something wrong with the server/api")
            }
        }
        creditViewModel.getCreditScore()
    }
    
    func injectDependencies(_ viewModel: Credit) {
        creditViewModel = viewModel
    }
    
    @IBAction func goToDetail(_ sender: UIButton) {
        coordinator?.detailPage()
    }
}


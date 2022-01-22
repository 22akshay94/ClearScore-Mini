//
//  ViewController.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var creditViewModel: Credit!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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
    
//    init(_ viewModel: Credit) {
//        self.creditViewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func injectDependencies(_ viewModel: Credit) {
        creditViewModel = viewModel
    }
    
    func setupView() {
        
        let containerView = UIView(frame: self.view.frame)
        containerView.backgroundColor = .white
        self.view.addSubview(containerView)
        
        let backgroundImgView = UIImageView(frame: containerView.frame)
        backgroundImgView.image = UIImage(named: "background")
        backgroundImgView.contentMode = .scaleAspectFill
        containerView.addSubview(backgroundImgView)
        
    }
}


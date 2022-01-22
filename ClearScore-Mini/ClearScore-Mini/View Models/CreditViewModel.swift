//
//  CreditViewModel.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import Foundation

protocol Credit {
    func getCreditScore()
    func getCreditInfo() -> CreditReportInfo
    
    var update: ((NetworkError) -> Void)? { get set }
}

class CreditViewModel<T: Decodable>: Credit {
    
    private var creditScore: CreditScore! {
        didSet {
            update?(.NoError)
        }
    }
    
    private var webService: WebService<T>
    private let resource: Resource<T>
    
    init(_ resource: Resource<T>, _ webService: WebService<T>) {
        self.resource = resource
        self.webService = webService
    }
    
    var update: ((NetworkError) -> Void)?
    
    func getCreditInfo() -> CreditReportInfo {
        return creditScore.creditReportInfo
    }
    
    
    func getCreditScore() {
        webService.load(resource: resource) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let creditScore):
                if let scoreModel = creditScore as? CreditScore {
                    self.creditScore = scoreModel
                }
            case .failure(let error):
                self.update?(error)
            }
        }
    }
}

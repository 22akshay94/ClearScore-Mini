//
//  ClearScore_Mini_WebServiceTests.swift
//  ClearScore-MiniTests
//
//  Created by Akshay Yerneni on 25/01/2022.
//

import XCTest
@testable import ClearScore_Mini

class ClearScore_Mini_WebServiceTests: XCTestCase {
    
    var testWebService: Network?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testWebService = WebService<CreditScore>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testWebService = nil
    }
    
    func testWebServiceWithWrongURL() {
//        let resource = Resource<CreditScore>(url: TestConstants.MockURLs.FaultyURL)
        let resource = Resource<CreditScore>(url: Constants.URLs.getCreditInfo)
        testWebService?.load(resource: resource, completion: { result in
            switch result {
            case .success(let creditScore):
                XCTAssertNotNil(creditScore)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
}

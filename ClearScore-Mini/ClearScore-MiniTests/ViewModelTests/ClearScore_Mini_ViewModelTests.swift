//
//  ClearScore_MiniTests.swift
//  ClearScore-MiniTests
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import XCTest
@testable import ClearScore_Mini

class ClearScore_Mini_ViewModelTests: XCTestCase {
    
    var testViewModel: CreditViewModel<CreditScore>?
    var mockWebService: MockWebService<CreditScore>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let resource = Resource<CreditScore>(url: Constants.URLs.getCreditInfo)
        mockWebService = MockWebService<CreditScore>()
        testViewModel = CreditViewModel(resource, mockWebService!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testViewModel = nil
        mockWebService = nil
    }
    
    func testViewModelParsingSuccessCorrectResponse() {
        
        mockWebService?.mockResponse = TestConstants.MockJSON.CorrectResponse
        testViewModel?.update = { [weak self] result in
            guard let self = self else {return}
            XCTAssertEqual(result, .NoError)
            XCTAssertNotNil(self.testViewModel?.getCreditInfo())
        }
        testViewModel?.getCreditScore()
    }
    
    func testViewModelParsingIncorrectResponse() {
        mockWebService?.mockResponse = TestConstants.MockJSON.IncorrectResponse
        testViewModel?.update = { result in
            XCTAssertNotEqual(result, .NoError)
        }
        testViewModel?.getCreditScore()
    }
}

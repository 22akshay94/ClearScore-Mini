//
//  ClearScore_MiniUITests.swift
//  ClearScore-MiniUITests
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import XCTest

class ClearScore_MiniUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNoInternetMessage() {
        
        app.launch()
        
        let loaderLabel = app.staticTexts["Fetching your credit score"]
        XCTAssertTrue(loaderLabel.exists)
        sleep(2)
        XCTAssertFalse(loaderLabel.exists)
        
        let donutView = app.otherElements["DonutView"]
        donutView.tap()
        
        
        let creditReportLabel = app/*@START_MENU_TOKEN@*/.staticTexts["CreditScoreLabel"]/*[[".staticTexts[\"514\"]",".staticTexts[\"CreditScoreLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(creditReportLabel.exists)
        
        let backButton = app.navigationBars["ClearScore_Mini.DetailView"].buttons["Back"]
        backButton.tap()
        
        XCTAssertTrue(donutView.exists)
    }
}

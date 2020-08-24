//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest

class ToDoAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
		continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--UITesting")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        XCTAssertTrue(app.isOnMainView)
		XCUIApplication().navigationBars["ToDoApp.TaskListVC"].buttons["Add"].tap()
		app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")
		
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Ufa")
		
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Bar")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.19")
        
        app.buttons["save"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Foo"].exists)
        XCTAssertTrue(app.tables.staticTexts["Bar"].exists)
        XCTAssertTrue(app.tables.staticTexts["01.01.19"].exists)
    }
    
    func testWhenCellIsSwipedLeftDoneButtonAppeared() {

        XCTAssertTrue(app.isOnMainView)
		XCUIApplication().navigationBars["ToDoApp.TaskListVC"].buttons["Add"].tap()
		app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")
		
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Ufa")
		
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Bar")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.19")
        
        app.buttons["save"].tap()
        
        XCTAssertTrue(app.isOnMainView)
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
    }
}

extension XCUIApplication {
    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }
}

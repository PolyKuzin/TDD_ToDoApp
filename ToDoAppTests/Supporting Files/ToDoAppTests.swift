//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
import UIKit
@testable import ToDoApp

class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testInitialViewControllerIsTaskListVC() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
		let rootViewController = navigationController.viewControllers.first as! TaskListVC
		
		XCTAssertTrue(rootViewController is TaskListVC)
	}
	
	
}

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
		super.setUp()
    }

    override func tearDownWithError() throws {
		super.tearDown()
    }

	func testInitialViewControllerIsTaskListVC() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
		let rootViewController = navigationController.viewControllers.first as! TaskListVC
		
		XCTAssertTrue(rootViewController is TaskListVC)
	}
}

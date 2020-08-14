//
//  TaskListViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 14.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskListViewControllerTests: XCTestCase {

	var sut: TaskListVC!
	
	//		let sut = TaskListVC()
	//									для элементов через код
	//		_ = sut.view
	
    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let vc =
			storyBoard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self))
		sut = vc as? TaskListVC
		
		sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testWhenViewIsLoadedTableViewIsNotNill() {
		
		XCTAssertNotNil(sut.tableView)
	}
	
	func testWhenViewIsLoadedDataProviderIsNotNil() {
		
		XCTAssertNotNil(sut.dataProvider)
	}
	
	func testWhenViewIsLoadedTableViewDelegateIsSet() {
		
		XCTAssertTrue(sut.tableView.delegate is DataProvider)
	}
	
	func testWhenViewIsLoadedTableViewDataSourceIsSet() {
		
		XCTAssertTrue(sut.tableView.dataSource is DataProvider)
	}
	
	func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSourse() {
		
		XCTAssertEqual(sut.tableView.delegate as? DataProvider,
					   sut.tableView.dataSource as? DataProvider)
	}
}

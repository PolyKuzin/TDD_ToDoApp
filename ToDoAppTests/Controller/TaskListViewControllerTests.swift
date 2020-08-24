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
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self))
        sut = vc as? TaskListVC
        
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenViewIsLoadedTableViewNotNil() {
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
    
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        XCTAssertEqual(
            sut.tableView.delegate 		as? DataProvider,
            sut.tableView.dataSource	as? DataProvider
        )
    }
	
	func testTaskListVCHasBarButtonWithSelfAsTarget() {
		let target = sut.navigationItem.rightBarButtonItem?.target
		XCTAssertEqual(target as? TaskListVC, sut)
	}
	
	func preparingNewTaskVC() -> NewTaskVC {
		guard
			let newTaskButton = sut.navigationItem.rightBarButtonItem,
			let action = newTaskButton.action else { return NewTaskVC() }
		
		UIApplication.shared.keyWindow?.rootViewController = sut
		sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
		
		let newTaskVC = sut.presentedViewController as! NewTaskVC
		return newTaskVC
	}
	
	func testAddNewTaskPresentsNewTaskVC() {
		let newTaskVC = preparingNewTaskVC()
		
		XCTAssertNotNil(newTaskVC.titleTextField)
	}
	
	func testSharesSameTaskManagerWithNewTaskVC() {
		let newTaskVC = preparingNewTaskVC()
		
		XCTAssertTrue(newTaskVC.taskManager === sut.dataProvider.taskManager)
	}
}

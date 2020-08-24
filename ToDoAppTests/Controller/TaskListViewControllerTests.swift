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
		super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self))
        sut = vc as? TaskListVC
        
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
		super.tearDown()
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
	
	func testWhenViewApperedTableViewReloded() {
		let mockTableView	= MockTableView()
		sut.tableView		= mockTableView
		
		sut.beginAppearanceTransition(true, animated: true)
		sut.endAppearanceTransition()
		
		XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
	}
	
	func testTapingCellSendsNotification() {
		let task = Task(title: "Foo")
		sut.dataProvider.taskManager?.add(task: task)
		expectation(forNotification: NSNotification.Name(rawValue: "DidselectRow notification"), object: nil) { notification -> Bool in
			guard let taskFromNotification = notification.userInfo?["task"] as? Task else { return false }
			return task == taskFromNotification
		}
		let tableView = sut.tableView
		tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
		waitForExpectations(timeout: 1, handler: nil)
	}
}

extension TaskListViewControllerTests {
	
	class MockTableView: UITableView {
		
		var isReloaded = false
		override func reloadData() {
			isReloaded = true
		}
	}
}

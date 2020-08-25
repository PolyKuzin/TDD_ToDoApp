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
        let storyboard	= UIStoryboard(name: "Main", bundle: nil)
        let vc			= storyboard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self))
        sut				= vc as? TaskListVC
        
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
			let newTaskButton	= sut.navigationItem.rightBarButtonItem,
			let action			= newTaskButton.action else { return NewTaskVC() }
		
		UIApplication.shared.keyWindow?.rootViewController = sut
		sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
		
		let newTaskVC = sut.presentedViewController as! NewTaskVC
		return newTaskVC
	}
	
	func testAddNewTaskPresentsNewTaskVC() {
		let newTaskVC			= preparingNewTaskVC()
		
		XCTAssertNotNil(newTaskVC.titleTextField)
	}
	
	func testSharesSameTaskManagerWithNewTaskVC() {
		let newTaskVC			= preparingNewTaskVC()
		
		XCTAssertTrue(newTaskVC.taskManager === sut.dataProvider.taskManager)
	}
	
	func testWhenViewApperedTableViewReloded() {
		let mockTableView		= MockTableView()
		sut.tableView			= mockTableView
		
		sut.beginAppearanceTransition(true, animated: true)
		sut.endAppearanceTransition()
		
		XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
	}
	
	func testTapingCellSendsNotification() {
		let task		= Task(title: "Foo")
		sut.dataProvider.taskManager?.add(task: task)
		expectation(forNotification: NSNotification.Name(rawValue: "DidselectRow notification"), object: nil) { notification -> Bool in
			guard let taskFromNotification = notification.userInfo?["task"] as? Task else { return false }
			
			return task == taskFromNotification
		}
		let tableView	= sut.tableView
		tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
		waitForExpectations(timeout: 1, handler: nil)
	}
	
	func testSelectedCellNotificationPushesDetailVC() {
		let mockNavigationController = MockNavigationController(rootViewController: sut)
		UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
		
		sut.loadViewIfNeeded()
		
		let task1	= Task(title: "Foo")
		let task2	= Task(title: "Bar")
		sut.dataProvider.taskManager?.add(task: task1)
		sut.dataProvider.taskManager?.add(task: task2)
		
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: self, userInfo: ["task" : task2])
		guard let detailViewController = mockNavigationController.pushedViewController as? DetailVC else {
			XCTFail()
			return
		}
		
		detailViewController.loadViewIfNeeded()
		XCTAssertNotNil(detailViewController.titleLabel)
		XCTAssertTrue(detailViewController.task == task2)
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

extension TaskListViewControllerTests {
	
	class MockNavigationController: UINavigationController {
		
		var pushedViewController : UIViewController?
		
		override func pushViewController(_ viewController: UIViewController, animated: Bool) {
			pushedViewController = viewController
			super.pushViewController(viewController, animated: animated)
		}
	}
}

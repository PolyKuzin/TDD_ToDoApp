//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 14.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {

	var sut	: DataProvider!
	var tableView	: UITableView!
	
	var controller: TaskListVC!
	
    override func setUpWithError() throws {
		sut = DataProvider()
		sut.taskManager	= TaskManager()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		controller = storyboard.instantiateViewController(identifier: String(describing: TaskListVC.self)) as? TaskListVC
		
		controller.loadViewIfNeeded()
		
		tableView = controller.tableView
		tableView.dataSource = sut
	}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testNumberOfSectionsIsTwo() {
		let numberOfSections = tableView.numberOfSections
		
		XCTAssertEqual(numberOfSections, 2)
	}
	
	func testNumberOfRowsInSectionZeroIsTasksCount() {
		
		sut.taskManager?.add(task: Task(title: "Foo"))
		
		XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
		
		tableView.reloadData()
		
		sut.taskManager?.add(task: Task(title: "Bar"))
		
		XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
	}
	
	func testNumberOfRowsInSectionOneIsDoneTasksCount() {
		sut.taskManager?.add(task: Task(title: "Foo"))
		sut.taskManager?.checkTask(at: 0)
		
		XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
		
		sut.taskManager?.add(task: Task(title: "Bar"))
		sut.taskManager?.checkTask(at: 0)

		tableView.reloadData()

		XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
	}
	
	func testCellForRowAtIndexPathReturnsTaskCell() {
		sut.taskManager?.add(task: Task(title: "Foo"))
		tableView.reloadData()
		
		let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
		
		XCTAssertTrue(cell is TaskCell)
	}
	
	func testCellForRowAtIndexpathDequeuesCellFromTableView() {
		let mockTableView = MockTableView()
		mockTableView.dataSource = sut
		mockTableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
		
		sut.taskManager?.add(task: Task(title: "Foo"))
		mockTableView.reloadData()
		
		_ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
		
		XCTAssertTrue(mockTableView.cellIsDequeued)
	}
}

extension DataProviderTests {
	
	class MockTableView: UITableView {
		var cellIsDequeued = false
		
		override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
			
			cellIsDequeued = true
			
			return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		}
	}
}

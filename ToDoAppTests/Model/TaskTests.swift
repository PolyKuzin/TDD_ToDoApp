//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")

        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar",
                        description: "Buz",
                        location: location)
        
        XCTAssertEqual(location, task.location)
    }
	
	func testCanBeCreatedFromPlistDictionary() {
		let date							= Date(timeIntervalSince1970: 10)
		let location						= Location(name: "Baz")
		let locationDict: [String : Any]	= ["name" : "Baz"]
		let task 							= Task(title		: "Foo",
													description	: "Bar",
													location	: location,
													date		: date)
		
		let dictionary: [String : Any]		= ["title"			: "Foo",
											   "description"	: "Bar",
											   "location"		: locationDict,
											   "date"			: date]
		let createdTask = Task(dict: dictionary)
		
		XCTAssertEqual(task, createdTask)
	}
}

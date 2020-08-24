//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
		super.setUp()
    }

    override func tearDownWithError() throws {
		super.tearDown()
    }
    
	func testInitSetsName() {
		let location = Location(name: "Foo")
		
		XCTAssertEqual(location.name, "Foo")
	}
	
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
		
		XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
		XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
	
	func testCanBeCreatedFromPlistDictionary() {
		let location = Location(name: "Foo",
								coordinate: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0))
		
		let dict: [String : Any] = ["name"		: "Foo",
									"latitude"	: 10.0,
									"longitude"	: 10.0]
		let createdLocation = Location(dict: dict)
		XCTAssertEqual(location, createdLocation)
	}
}

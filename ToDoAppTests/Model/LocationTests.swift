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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}

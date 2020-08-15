//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 15.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class DetailViewControllerTests: XCTestCase {

	var sut : DetailVC!
	
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC
		sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testHasTitleLabel() {
		XCTAssertNotNil(sut.titleLabel)
		XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
	}
	
	func testHasDescriptionLabel() {
		XCTAssertNotNil(sut.descriptionLabel)
		XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
	}
	
	func testHasDateLabel() {
		XCTAssertNotNil(sut.dateLabel)
		XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
	}
	
	func testHasLocationLabel() {
		XCTAssertNotNil(sut.locationLabel)
		XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
	}
	
	func testHasMapView() {
		XCTAssertNotNil(sut.mapView)
		XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
	}
	
	func setUpTaskAndAppearenceTransition() {
		let date = Date(timeIntervalSince1970: 1546300800)
		let coordinate = CLLocationCoordinate2D(latitude: 55.66114461, longitude: 37.41550684)
		let location = Location(name: "Baz", coordinate: coordinate)
		let task = Task(title: "Foo", description: "Bar", location: location, date: date)
		sut.task = task
		
		sut.beginAppearanceTransition(true, animated: true)
		sut.endAppearanceTransition()
	}
	
	func testSettingTaskSetsTitleLabel() {
		setUpTaskAndAppearenceTransition()
		XCTAssertEqual(sut.titleLabel.text, "Foo")
	}
	
	func testSettingTaskSetsDescriptionLabel() {
		setUpTaskAndAppearenceTransition()
		XCTAssertEqual(sut.descriptionLabel.text, "Bar")
	}
	
	func testSettingTaskSetsLocationLabel() {
		setUpTaskAndAppearenceTransition()
		XCTAssertEqual(sut.locationLabel.text, "Baz")
	}
	
	func testSettingTaskSetsDateLabel() {
		setUpTaskAndAppearenceTransition()
		XCTAssertEqual(sut.dateLabel.text, "01.01.19")
	}
	
	func testSettingTaskSetsMapView() {
		setUpTaskAndAppearenceTransition()
		XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 55.66114461, accuracy: 0.01)
		XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 37.41550684, accuracy: 0.01)
	}
}

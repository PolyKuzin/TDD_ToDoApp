//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 15.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {

	var sut : NewTaskVC!
	var placemark : MockCLPlaceMark!
	
    override func setUpWithError() throws {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard .instantiateViewController(withIdentifier: String(describing: NewTaskVC.self)) as? NewTaskVC
		sut.loadViewIfNeeded()
	}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testHasTitleTextField() {
		XCTAssertTrue((sut.titleTextField.isDescendant(of: sut.view)))
	}
	
	func testHasLocationTextField() {
		XCTAssertTrue((sut.locationTextField.isDescendant(of: sut.view)))
	}
	
	func testHasAdressTextField() {
		XCTAssertTrue((sut.adressTextField.isDescendant(of: sut.view)))
	}
	
	func testHasDescriptionTextField() {
		XCTAssertTrue((sut.descriptionTextField.isDescendant(of: sut.view)))
	}
	
	func testHasCancelButton() {
		XCTAssertTrue((sut.cancelButton.isDescendant(of: sut.view)))
	}
	
	func testHasSaveButton() {
		XCTAssertTrue((sut.saveButton.isDescendant(of: sut.view)))
	}
	
	func testSaveUsesGeocoderToConverCoordinateFromAdress() {
		let df = DateFormatter()
		df.dateFormat = "dd.MM.yy"
		let date = df.date(from: "01.01.19")
		sut.titleTextField.text = "Foo"
		sut.descriptionTextField.text = "Bar"
		sut.dateTextField.text = "01.01.19"
		sut.adressTextField.text = "Уфа"
		sut.locationTextField.text = "Baz"
		sut.taskManager = TaskManager()
		
		let mockGeocoder = MockCLGeocoder()
		sut.geocoder = mockGeocoder
		sut.save()
		
		let coordinate = CLLocationCoordinate2D(latitude: 54.7373058, longitude: 55.9722491)
		let location = Location(name: "Baz", coordinate: coordinate)
		let generatedTask = Task(title: "Foo", description: "Bar", location: location, date: date)
		placemark = MockCLPlaceMark()
		placemark.mockCoordinate = coordinate
		mockGeocoder.complitionHandler?([placemark], nil)
		
		let task = sut.taskManager.task(at: 0)
		
		XCTAssertEqual(task, generatedTask)
	}
	
	func testSaveButtonHaveSaveMethod() {
		let saveButton = sut.saveButton
		
		guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else { XCTFail(); return }
		XCTAssertTrue(actions.contains("save"))
	}
}

extension NewTaskViewControllerTests {
	
	class MockCLGeocoder: CLGeocoder {
		
		var complitionHandler: CLGeocodeCompletionHandler?
		
		override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
			self.complitionHandler = completionHandler
		}
	}
	
	class MockCLPlaceMark: CLPlacemark {
		
		var mockCoordinate: CLLocationCoordinate2D!
		
		override var location: CLLocation? {
			return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
		}
	}
}
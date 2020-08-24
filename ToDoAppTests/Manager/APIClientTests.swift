//
//  APIClentTests.swift
//  ToDoAppTests
//
//  Created by Павел Кузин on 24.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import XCTest
@testable import ToDoApp

class APIClientTests: XCTestCase {

	var sut				: APIClient!
	var mockURLSession	: MockURLSession!
	
    override func setUpWithError() throws {
		sut				= APIClient()
		mockURLSession	= MockURLSession()
		sut.urlSession	= mockURLSession
	}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func userLogin() {
		let complitionHandler = {(token: String?, error: Error?) in }
		sut.login(withName: "name", password: "%qwerty", complitionHandler: complitionHandler)
	}

	func testLoginUsesCorrectHost() {
		userLogin()
		XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
	}
	
	func testLoginUsesCorrectPath() {
		userLogin()
		XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
	}
	
	func testLoginUsesExpextedQueryParameters() {
		userLogin()
		
		guard let queryItems = mockURLSession.urlComponents?.queryItems else {
			XCTFail()
			return
		}
		
		let urlQueryItemName = URLQueryItem(name: "name", value: "name")
		let urlQueryItemPassword = URLQueryItem(name: "password", value: "%qwerty")

		XCTAssertTrue(queryItems.contains(urlQueryItemName))
		XCTAssertTrue(queryItems.contains(urlQueryItemPassword))
	}
}

extension APIClientTests {
	
	class MockURLSession: URLSessionProtocol {
		
		var url				: URL?
		var urlComponents	: URLComponents? {
			guard let url = url else { return nil }
			return URLComponents(url: url, resolvingAgainstBaseURL: true)
		}
		
		func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
			self.url = url
			return URLSession.shared.dataTask(with: url)
		}
	}
}

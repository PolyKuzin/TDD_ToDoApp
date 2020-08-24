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
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8)
		sut				= APIClient()
		mockURLSession	= MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
		sut.urlSession	= mockURLSession
	}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func userLogin() {
		let complitionHandler = {(token: String?, error: Error?) in }
		sut.login(withName: "name", password: "%qwerty", completionHandler: complitionHandler)
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
	
	func testSuccessfulLoginCreatesToken() {
//        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        let tokenExpectation = expectation(description: "Token expectation")

        var caughtToken: String?
        sut.login(withName: "login", password: "password") { token, _ in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken, "tokenString")
        }
    }
}

extension APIClientTests {
	
	 class MockURLSession: URLSessionProtocol {
		
		var url: URL?
		private let mockDataTask: MockURLSessionDataTask
			
		var urlComponents: URLComponents? {
			guard let url = url else { return nil }
			return URLComponents(url: url, resolvingAgainstBaseURL: true)
		}
			
		init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
			mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
		}
			
		func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
			self.url = url
//            return URLSession.shared.dataTask(with: url)
			mockDataTask.completionHandler = completionHandler
			return mockDataTask
		}
	}
	
	class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data			: Data?
        private let urlResponse		: URLResponse?
        private let responseError	: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler		: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data				= data
            self.urlResponse		= urlResponse
            self.responseError		= responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler? (
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}
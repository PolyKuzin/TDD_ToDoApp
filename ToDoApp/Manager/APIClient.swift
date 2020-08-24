//
//  APIClent.swift
//  ToDoApp
//
//  Created by Павел Кузин on 24.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
	
	func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: URLSessionProtocol{ }
	
class APIClient {
	
	lazy var urlSession: URLSessionProtocol = URLSession.shared
	
	func login(withName name: String, password: String, completionHandler: @escaping(String?, Error?) -> Void) {
		let allowedCharacters	= CharacterSet.urlQueryAllowed
		guard
			let name		= name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
			let password	= password.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
		else { fatalError() }

		let query				= "name=\(name)&password=\(password)"
		guard let url = URL(string: "https://todoapp.com/login?\(query)") else { fatalError() }
		
		urlSession.dataTask(with: url) { (data, responce, error) in
			guard let data = data else { fatalError() }
			let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : String]

			let token = dictionary["token"]
			completionHandler(token, nil)
		}.resume()
	}
}
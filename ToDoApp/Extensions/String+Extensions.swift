//
//  String+Extensions.swift
//  ToDoApp
//
//  Created by Павел Кузин on 24.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation

extension String {

	var percentEncoded: String {
		let allowedCharacters = CharacterSet(charactersIn: "±!@#$%^&*()_+=\\{}<>?").inverted
		guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { fatalError() }
		return encodedString
	}
}

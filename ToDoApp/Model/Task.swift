//
//  Task.swift
//  ToDoApp
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation

struct Task {
    let title				: String
    let description			: String?
    let location            : Location?
    private(set) var date   : Date?
    
    init(title: String, description: String? = nil, location: Location? = nil) {
        self.title          = title
        self.description    = description
        self.location       = location
        self.date           = Date()
    }
}

extension Task: Equatable {
	static func == (lhs: Task, rhs: Task) -> Bool {
		if
			lhs.title == rhs.title,
			lhs.description == rhs.description,
			lhs.location == rhs.location {
			return true
		}
		return false
	}
}

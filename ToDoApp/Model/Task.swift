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
    let date   				: Date
    
	init(title: String, description: String? = nil, location: Location? = nil, date: Date? = nil) {
        self.title          = title
        self.description    = description
        self.location       = location
        self.date           = date ?? Date()
    }
}

extension Task: Equatable {
	static func == (lhs: Task, rhs: Task) -> Bool {
		if
			lhs.title		== rhs.title,
			lhs.description	== rhs.description,
			lhs.location	== rhs.location {
			return true
		}
		return false
	}
}

extension Task {
	typealias PlistDictionary = [String : Any]
	init?(dict: PlistDictionary) {
		self.title			= dict["title"]			as! String
		self.description	= dict["description"]	as? String
		self.date			= dict["date"]			as? Date ?? Date()
		if let locationDict	= dict["location"]		as? [String : Any] {
			self.location	= Location(dict: locationDict)
		} else {
			self.location	= nil
		}
	}
}

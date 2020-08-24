//
//  NewTaskVC.swift
//  ToDoApp
//
//  Created by Павел Кузин on 15.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import CoreLocation

class NewTaskVC: UIViewController {

	var taskManager : TaskManager!
	var geocoder 	= CLGeocoder()
	
	@IBOutlet weak var titleTextField		: UITextField!
	@IBOutlet weak var locationTextField	: UITextField!
	@IBOutlet weak var adressTextField		: UITextField!
	@IBOutlet weak var descriptionTextField	: UITextField!
	@IBOutlet weak var dateTextField		: UITextField!
	@IBOutlet weak var cancelButton			: UIButton!
	@IBOutlet weak var saveButton			: UIButton!
	
	@IBAction func save() {
//TODO: Проверка на ДАТУ определенного формата

		let titleString			= titleTextField.text
		let descriptionString	= descriptionTextField.text
		let locationString		= locationTextField.text
		let date				= dateFormatter.date(from: dateTextField.text!)
		let adressString		= adressTextField.text
		
		geocoder.geocodeAddressString(adressString!) { [unowned self] (placemarks, err) in
			let placemark		= placemarks?.first
			let coordinate		= placemark?.location?.coordinate
			let location		= Location(name			: locationString!,
										   coordinate	: coordinate)
			let task			= Task(title: titleString!,
								   description: descriptionString,
								   location: location,
								   date: date)
			self.taskManager.add(task: task)
		}
	}
	
	var dateFormatter : DateFormatter {
		let df			= DateFormatter()
		df.dateFormat	= "dd.MM.yy"
		return df
	}
}

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
	
	@IBOutlet var titleTextField		: UITextField!
	@IBOutlet var locationTextField		: UITextField!
	@IBOutlet var adressTextField		: UITextField!
	@IBOutlet var descriptionTextField	: UITextField!
	@IBOutlet var dateTextField			: UITextField!
	@IBOutlet var cancelButton			: UIButton!
	@IBOutlet var saveButton			: UIButton!
	
	@IBAction func save() {
//TODO: Check Date For Formate
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
			let task			= Task(title	: titleString!,
								   description	: descriptionString,
								   location		: location,
								   date			: date)
			self.taskManager.add(task: task)
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	var dateFormatter	: DateFormatter {
		let df			= DateFormatter()
		df.dateFormat	= "dd.MM.yy"
		
		return df
	}
}

//
//  ViewController.swift
//  ToDoApp
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class TaskListVC: UIViewController {
	
	@IBOutlet weak var tableView	: UITableView!
	@IBOutlet var dataProvider		: DataProvider!
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
}


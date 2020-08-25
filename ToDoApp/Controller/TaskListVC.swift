//
//  ViewController.swift
//  ToDoApp
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class TaskListVC: UIViewController {
	
	@IBOutlet var tableView			: UITableView!
	@IBOutlet var dataProvider		: DataProvider!
	
	@IBAction func addNewTaskButton(_ sender: UIBarButtonItem) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskVC.self))
			as? NewTaskVC {
			vc.taskManager = self.dataProvider.taskManager
			present(vc, animated: true, completion: nil)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager				= TaskManager()
        dataProvider.taskManager	= taskManager

		NotificationCenter.default.addObserver(self, selector: #selector(showDetail(withNotification:)), name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil)

        view.accessibilityIdentifier = "mainView"
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	@objc func showDetail(withNotification notification: Notification) {
		guard
			let userInfo					= notification.userInfo,
			let task						= userInfo["task"] as? Task else { fatalError() }
		if let detailViewController			= storyboard?.instantiateViewController(withIdentifier: "DetailVC")
			as? DetailVC {
			detailViewController.task		= task
			navigationController?.pushViewController(detailViewController, animated: true)
			print("!!!!!!")
		}
		print("!!!!!!")
	}
}


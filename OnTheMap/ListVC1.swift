//
//  ListVC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 6/1/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit

class ListVC1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func refreshList() {
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PM.standard.students.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let student = PM.standard.students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StudentCell
        cell.label.text = student.fullName
        return cell
    }

}

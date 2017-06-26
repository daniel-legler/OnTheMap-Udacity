//
//  List_VC.swift
//  OnTheMap
//
//  Created by Daniel Legler on 6/16/17.
//  Copyright © 2017 Daniel Legler. All rights reserved.
//

import UIKit

class ListVC: UITableViewController {
    
    func refreshList() {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PM.standard.students.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let student = PM.standard.students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StudentCell
        cell.label.text = student.fullName
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let student = PM.standard.students[indexPath.row]
        
        let link = student.mediaUrl
        
        if let url = URL(string: link) {
            PM.standard.openURL(url: url)
        } else {
            alert(title: "Error", message: "No link found")
        }
        
    }
    
  
}


//
//  CellChartTableViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/2/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit

class CellChartTableViewController: UITableViewController {
    
    let rooms : [String] = ["Atrium","Forum","East Reception","West Reception","Main Lobby","Perry Pavilion", "GSR 132","GSR 134","GSR 144"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "White-Clouds-At-high-Altitudes")!)
        
    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! CustomTableViewCell
        
        cell.setDataCount()
        cell.setChart()
        cell.label.text=rooms[indexPath.row]
        cell.cellView.layer.cornerRadius=cell.cellView.frame.height/4
        
        return cell
    }
    
}

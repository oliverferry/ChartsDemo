//
//  TableViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let list = ["Line Chart", "Bar Chart", "Radar Chart", "Real-time Chart", "Table View Cell Chart", "Horizontal Bar Chart"]
    let details = [
        "basic line chart with gradient fill",
        "limit-line Bar chart with balloon marker",
        "basic Radar chart with gradient fill",
        "dynamic line chart being fed live data",
        "pie chart and bar chart embedded in custom table view cell",
        "Simple Horizontal Bar Chart"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (list.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.detailTextLabel?.text = details[indexPath.row]

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "LineChartVC", sender: self)
        case 1:
            performSegue(withIdentifier: "BarChartVC", sender: self)
        case 2:
            performSegue(withIdentifier: "RadarChartVC", sender: self)
        case 3:
            performSegue(withIdentifier: "LiveChartVC", sender: self)
        case 4:
            performSegue(withIdentifier: "CellChartVC", sender: self)
        case 5:
            performSegue(withIdentifier: "HorizontalChartVC", sender: self)
        default:
            print(indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

}

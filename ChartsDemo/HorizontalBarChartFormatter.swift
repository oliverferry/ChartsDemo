//
//  HorizontalBarChartFormatter.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Foundation
import Charts

class HorizontalBarChartFormatter: NSObject, IAxisValueFormatter {
    
    var List : [String]! = ["Korea", "Germany","United Kingdom","India","France", "Italy", "Brazil", "Canada", "Russia", "Spain", "Australia", "Mexico","China","Japan","USA"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "      " + List[Int((value+1) / 1.75)]
    }
    
    
}

//
//  LineChartViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    let Hback : Int = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        updateGraph(dataPoints:getTimes(Inithour: hour))
        // Do any additional setup after loading the view.
    }
    
    func getTimes (Inithour: Int) -> [String]{
        var currhour: Int = Inithour-Hback
        var x: Int = 1
        var y: String = " AM"
        var times = [String]()
        for counter in 0..<(Hback*2+3) {
            if currhour<12 || currhour==24 {
                y = " AM"
                if currhour==24 {x=12}
                else {x=currhour}
            }
            else {
                x=currhour-12
                y = " PM"
            }
            if counter%2==0{
                times.append("")
            }
            else {
                if (x==0){x=12}
                times.append(String(x)+y)
                currhour += 1
            }
        }
        return times
    }
    
    
    @objc func updateGraph(dataPoints: [String]){
        var lineChartEntry = [ChartDataEntry]()
        //here is the for loop
        for i in 0..<dataPoints.count {
            let rand = Int(arc4random_uniform(100))
            let value = ChartDataEntry(x: Double(i), y: Double(rand)) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        let line1 = LineChartDataSet(entries: lineChartEntry, label: nil) //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        line1.drawCirclesEnabled=false
        line1.mode=LineChartDataSet.Mode.horizontalBezier
        line1.lineWidth=3
        let coloTop = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 0.9).cgColor
        let colorBottom = UIColor.white.cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.7, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        line1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        line1.drawFilledEnabled = true // Draw the Gradient
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        data.setDrawValues(false)
        
        
        
        
        lineChartView.data = data
        //adds the chart data to the chart and causes an update
        
        lineChartView.chartDescription?.enabled = false
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChartView.animate(yAxisDuration: 1.2, easingOption: .easeOutCubic)
        lineChartView.rightAxis.enabled=false
        lineChartView.xAxis.granularity = 1.0
        lineChartView.leftAxis.axisMinimum = -0.1
        lineChartView.rightAxis.axisMinimum = -0.1
        lineChartView.leftAxis.axisMaximum = 100
        lineChartView.rightAxis.axisMaximum = 100
        lineChartView.rightAxis.drawGridLinesEnabled=false
        lineChartView.xAxis.drawAxisLineEnabled=false
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChartView.legend.enabled=false
        lineChartView.scaleYEnabled=false
        lineChartView.setVisibleXRangeMaximum(8)
        lineChartView.moveViewToX(Double(Hback*2-6))
        
    }

}

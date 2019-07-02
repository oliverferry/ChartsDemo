//
//  LiveViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Charts

class LiveViewController: UIViewController {
    @IBOutlet weak var chartView: LineChartView!
    
    var timer = Timer()
    
    var ray: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        var datap = [String]()
        for _ in 0...19{
            datap.append("")
        }
        for _ in 0...19{
            ray.append(20)
        }
        updateGraph(dataPoints: datap)
        timer = Timer.scheduledTimer(timeInterval: 0.02, target:self, selector: #selector(LiveViewController.update), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    @objc func update() {
        var y = ray[ray.count-1]
        //adding a random dummy reading to the graph 1/5 of the time intervals
        let rand = Double.random(in: 0 ..< 80)
        if (Int(rand)%5==0){
            y=rand
        }
        ray.removeFirst()
        ray.append(y)
        for i in 0...ray.count-1 {
            let entry = chartView.data?.dataSets[0].entryForIndex(i)
            entry?.y=ray[i]
        }
        self.chartView.notifyDataSetChanged()
    }
    
    @objc func updateGraph(dataPoints: [String]){
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<dataPoints.count {
            let value = ChartDataEntry(x: Double(i), y: Double(20))
            // here we set the X and Y status in a data chart entry
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
        
        
        
        
        chartView.data = data //adds the chart data to the chart and causes an update
        
        chartView.chartDescription?.enabled = false
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        chartView.animate(yAxisDuration: 1.2, easingOption: .easeOutCubic)
        chartView.rightAxis.enabled=false
        chartView.xAxis.granularity = 1.0
        chartView.leftAxis.axisMinimum = -0.1
        chartView.rightAxis.axisMinimum = -0.1
        chartView.leftAxis.axisMaximum = 100
        chartView.rightAxis.axisMaximum = 100
        chartView.rightAxis.drawGridLinesEnabled=false
        chartView.xAxis.drawAxisLineEnabled=false
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.legend.enabled=false
        chartView.scaleYEnabled=false
    }
    
}

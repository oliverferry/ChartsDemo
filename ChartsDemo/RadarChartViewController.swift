//
//  RadarChartViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Charts

class RadarChartViewController: UIViewController {

    @IBOutlet weak var RadarChartView: RadarChartView!
    let subjects = ["12 AM", "3 AM", "6 AM", "9 AM", "12 PM", "3 PM", "6 PM", "9 PM"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setRadarChart(dataPoints: subjects)

        // Do any additional setup after loading the view.
    }
    

        func setRadarChart(dataPoints: [String]) {
            let values = [1.0, 1.0, 1.0, 2.0, 1.0, 2.0, 1.0, 0.0]
            let values2 = [0, 2.0, 1.0, 1.0, 2.0, 2.0, 1.0, 2.0]
            RadarChartView.noDataText = "You need to provide data for the chart."
            //AM_______________________________________
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
            }
            let chartDataSet = RadarChartDataSet(entries: dataEntries, label: "Graph 1")
            chartDataSet.drawValuesEnabled=false
            chartDataSet.setColor(UIColor.blue)
          //PM__________________________________________
            var dataEntries2: [ChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: values2[i], data: dataPoints[i] as AnyObject)
                dataEntries2.append(dataEntry)
            }
            let chartDataSet2 = RadarChartDataSet(entries: dataEntries2, label: "Graph 2")
            chartDataSet2.drawValuesEnabled=false
            chartDataSet2.setColor(UIColor.purple)
            chartDataSet2.fillColor = UIColor.purple
            chartDataSet2.drawFilledEnabled = true
            chartDataSet2.fillAlpha = 0.2
    
    
            //Options of radarChart
            RadarChartView.sizeToFit()
            RadarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
    
            RadarChartView.chartDescription?.enabled=false
            RadarChartView.yAxis.drawLabelsEnabled=false
    
    
            RadarChartView.rotationEnabled = false
            chartDataSet.drawFilledEnabled = true
    
            //Other options
//            RadarChartView.legend.enabled = false
            RadarChartView.yAxis.gridAntialiasEnabled = true
            RadarChartView.animate(yAxisDuration: 2.0)
    
            //add the data
            let chartData = RadarChartData(dataSets: [chartDataSet,chartDataSet2])
            RadarChartView.data = chartData
        }

}

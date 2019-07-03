//
//  HorizontalBarViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Charts

class HorizontalBarViewController: UIViewController {

    @IBOutlet weak var chart: HorizontalBarChartView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChartWithTab()
        
        chart.legend.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        //chart.xAxis.drawLabelsEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        
        chart.dragEnabled = true
        chart.scaleYEnabled = false
        chart.scaleXEnabled = false
        
        chart.extraTopOffset = 15.0
        chart.setVisibleXRangeMaximum(20.0)
//        chart.fitScreen()
//        chart.moveViewToX(Double(0))

        let formatter = HorizontalBarChartFormatter()
        
        chart.xAxis.granularity = 1.75
        chart.xAxis.labelCount = 15
        
        chart.xAxis.valueFormatter = formatter
        
        chart.xAxis.labelPosition = XAxis.LabelPosition.top
        chart.chartDescription?.text = ""
        chart.notifyDataSetChanged()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChartWithTab( ) {
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0..<15 {
            let dataEntry : BarChartDataEntry!
            dataEntry = BarChartDataEntry.init(x: Double(i) * 1.75, y: Double(i * 6))
            
            //  (x: 0.5, y: 0.1, data: "f" as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "test")
        chartDataSet.highlightEnabled = false
        chartDataSet.colors = [UIColor.red]
        
        chartDataSet.valueFont = UIFont.systemFont(ofSize: 10.0)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 1.0
        
        chart.fitBars = false
        chart.data = chartData

    }
    
}


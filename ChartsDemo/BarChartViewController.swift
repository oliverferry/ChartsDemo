//
//  BarChartViewController.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/1/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var chartView: BarChartView!
    
    let targ = 2000.0
    var days: [String]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Chart Setup
        chartView.delegate = self
        days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
        let cals = [1800.0,1750.0,2100.0,2000.0,2400.0,1800.0,2070.0,1800.0,1750.0,2100.0,2000.0,2400.0,1800.0,0.0]
        setChart(dataPoints: days, Calories: cals)
        chartSettings(cals: cals)
        
        
    }
    
    // MARK: - Chart Setup functions
    func setChart(dataPoints: [String], Calories: [Double])
    {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<days.count
        {
            var dataEntry : BarChartDataEntry
            if Double(Calories[i])<=targ{
                dataEntry = BarChartDataEntry(x: Double(i), y: Double(Calories[i]))
            }
            else{
                let val1 = targ
                let val2 = Double(Calories[i])-targ
                dataEntry = BarChartDataEntry(x: Double(i), yValues: [val1,val2])
            }
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Calories")
        
        chartDataSet.resetColors()
        for cal in Calories{
            if Double(cal) <= targ{
                chartDataSet.addColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
            }
            else{
                chartDataSet.addColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                chartDataSet.addColor(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
            }
        }
        chartDataSet.highlightAlpha = -0.3
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)
        chartView.data = chartData
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        
        let marker : BalloonMarker = BalloonMarker(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: CGFloat(80.0), height: CGFloat(40.0))
        chartView.marker = marker
    }
    
    func chartSettings(cals: [Double]){
        // Chart View settings:
        chartView.legend.enabled = false
        chartView.animate(yAxisDuration: 1.2, easingOption: .easeOutCubic)
        chartView.xAxis.drawAxisLineEnabled=false
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.rightAxis.drawGridLinesEnabled=false
        
        let ll = ChartLimitLine(limit: targ, label: "")
        ll.valueTextColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        chartView.leftAxis.addLimitLine(ll)
        chartView.rightAxis.drawLabelsEnabled = false
        
        chartView.xAxis.gridLineDashLengths = [3.0]
        var min = Double(cals[0 ..< cals.count-1].min() ?? 0)
        if min > targ {min = targ}
        if min > 100{
            chartView.leftAxis.axisMinimum = min-100.0
            chartView.rightAxis.axisMinimum = min-100.0
        }
        
        //set range for x-axis and initial positioning
        chartView.setVisibleXRangeMaximum(7)
        chartView.moveViewToX(Double(cals.count-5))
        
        chartView.highlightFullBarEnabled = true
        chartView.doubleTapToZoomEnabled = false
    }
    
    // MARK: - ChartViewDelegate
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
        print(entry.description)
    }
    
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
}





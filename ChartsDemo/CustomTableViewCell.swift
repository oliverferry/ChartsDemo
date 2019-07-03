//
//  CustomTableViewCell.swift
//  ChartsDemo
//
//  Created by Oliver Ferry on 7/2/19.
//  Copyright © 2019 Oliver Ferry. All rights reserved.
//

import UIKit
import Charts

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var horChart: HorizontalBarChartView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var PieChartView: PieChartView!
    
    var currHour: Int = 0
    let backColor: UIColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        currHour = hour
        
        horChart.drawBarShadowEnabled = false
        horChart.drawValueAboveBarEnabled = true
        horChart.dragYEnabled=false
        
        horChart.maxVisibleCount = 60
        horChart.zoomIn()
        horChart.legend.enabled=false
        horChart.chartDescription?.enabled=false
        
        let xAxis = horChart.xAxis
        xAxis.drawLabelsEnabled=false
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 10
        
        let leftAxis = horChart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.valueFormatter = IndexAxisValueFormatter(values:getTimes(Inithour: hour))
        
        let rightAxis = horChart.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.drawLabelsEnabled=false
        rightAxis.axisMinimum = 0
        rightAxis.valueFormatter = IndexAxisValueFormatter(values:getTimes(Inithour: hour))
        
        let l = horChart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        horChart.legend = l
        horChart.fitBars = true
        horChart.animate(yAxisDuration: 2.5)
    }
    
    func getTimes (Inithour: Int) -> [String]{
        var currhour: Int = Inithour-3
        var x: Int = 1
        var y: String = " AM"
        var times = [String]()
        for counter in 0..<9 {
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
    
    func setDataCount() {
        let values:[Double]
        values = [2.0,0.3,1.0,0.7,1.0,2.0,1.0].shuffled()
        let barWidth = 9.0
        let spaceForBar = 10.0
        
        let yVals = (0..<1).map { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i)*spaceForBar, yValues: values)
        }
        var colors = [UIColor]()
        for x in 0..<values.count{
            if (x%2==0){
                colors.append(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
            }
            else {
                colors.append(UIColor(red: 90/255, green: 200/255.0, blue: 1.0, alpha: 1.0))
            }
        }
        let set1 = BarChartDataSet(entries: yVals, label: "DataSet")
        set1.drawIconsEnabled = false
        set1.colors=colors
        set1.highlightEnabled=false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        data.setDrawValues(false)
        
        horChart.data = data
        
    }
    
    func setChart() {
        var dataEntries: [ChartDataEntry] = []
        let X = Double.random(in: 0 ..< 100)
        let values: [Double] = [X,100-X]
        let dataPoints: [String] = ["a","b"]
        for i in 0..<dataPoints.count {
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            
            dataEntries.append(dataEntry1)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        pieChartDataSet.drawValuesEnabled=false
        pieChartDataSet.valueLineWidth=1
        pieChartDataSet.selectionShift=0
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        PieChartView.data = pieChartData
        PieChartView.legend.enabled=false
        PieChartView.chartDescription?.enabled=false
        PieChartView.holeColor=UIColor.clear
        PieChartView.holeRadiusPercent = 0.7
        PieChartView.centerTextRadiusPercent=4
        PieChartView.centerText = String(Int(values[0]))+"%"
        let colors: [UIColor] = [UIColor(red: 0, green: 122/255, blue: 1, alpha: 1),UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)]
        PieChartView.isUserInteractionEnabled=false
        pieChartDataSet.colors = colors
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

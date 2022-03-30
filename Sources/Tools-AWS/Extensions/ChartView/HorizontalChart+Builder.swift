//
//  HorizontalChart+Builder.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 3/17/22.
//

import Foundation
import UIKit
import Charts

extension HorizontalBarChartView {
    func buildHorizontal(_ chartData: [String: Int], _ totalItemCount: Int) -> BarChartData? {
        
        var entries: [BarChartDataEntry] = []
        for (index, count) in chartData.enumerated() { entries.append(BarChartDataEntry(x: Double(index), y: Double( count.value * 100 / totalItemCount))) }
        
        drawBarShadowEnabled = false
        drawValueAboveBarEnabled = true
        
        maxVisibleCount = 60
        
        let xAxis = xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10
        
        let leftAxis = leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0
        
        let rightAxis = rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0
        
        let l = legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        
        fitBars = true
        animate(yAxisDuration: 2.5)
        
        let dataSet = BarChartDataSet(entries: entries, label: "DataSet")
        dataSet.drawIconsEnabled = false
        return BarChartData(dataSet: dataSet)
    }
}

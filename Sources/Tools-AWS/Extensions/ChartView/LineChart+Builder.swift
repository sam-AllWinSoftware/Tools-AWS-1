//
//  LineChart+Builder.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 3/17/22.
//

import Foundation
import Charts
import UIKit

extension LineChartView {
    
    func build(_ chartData: [String: Int], _ totalItemCount: Int) -> LineChartData {
        
        var entries: [ChartDataEntry] = []
        for (index, count) in chartData.enumerated() { entries.append(ChartDataEntry(x: Double(index), y: Double( count.value * 100 / totalItemCount))) }
        let dataSet = LineChartDataSet(entries: entries, label: "Line Chart")
        dataSet.drawIconsEnabled = false
        lineChartConfig(dataSet)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        dataSet.fillAlpha = 1
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        
        return LineChartData(dataSet: dataSet)
    }
    
    private func lineChartConfig(_ dataSet: LineChartDataSet) {
        let isDrawLineWithGradientEnabled = dataSet.isDrawLineWithGradientEnabled
        dataSet.lineDashLengths = isDrawLineWithGradientEnabled ? nil : [5, 2.5]
        dataSet.highlightLineDashLengths = isDrawLineWithGradientEnabled ? nil : [5, 2.5]
        dataSet.gradientPositions = isDrawLineWithGradientEnabled ? [0, 40, 100] : nil
        dataSet.formLineDashLengths = isDrawLineWithGradientEnabled ? nil : [5, 2.5]
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
        dataSet.lineWidth = 1
        dataSet.circleRadius = 3
        dataSet.setCircleColor(.black)
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 9)
        
        if isDrawLineWithGradientEnabled { dataSet.setColors(.black, .red, .white) }
        else { dataSet.setColor(.black) }
    }
}

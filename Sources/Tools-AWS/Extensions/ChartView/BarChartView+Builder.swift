//
//  BarChartView+Builder.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 3/17/22.
//

import Foundation
import UIKit
import Charts

extension BarChartView {
    func build(_ chartData: [String: Int], _ totalItemCount: Int) -> BarChartData? {
        
        var entries: [BarChartDataEntry] = []
        for (index, count) in chartData.enumerated() { entries.append(BarChartDataEntry(x: Double(index), y: Double( count.value * 100 / totalItemCount))) }
        
        var set1: BarChartDataSet! = nil
        if let set = data?.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(entries)
            data?.notifyDataChanged()
            notifyDataSetChanged()
            return nil
        } else {
            set1 = BarChartDataSet(entries: entries, label: "Bar Chart")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            return data
        }
    }
}

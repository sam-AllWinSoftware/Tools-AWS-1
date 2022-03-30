//
//  PieChartView+Builder.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 3/17/22.
//

import UIKit
import Charts

extension PieChartView {
    
    func build(_ chartData: [String: Int], _ label: String?, _ totalItemCount: Int) -> PieChartData? {
        
        guard let label = label else { return nil }
        var entries: [PieChartDataEntry] = []
        for count in chartData { entries.append(PieChartDataEntry(value: Double(count.value * 100 / totalItemCount), label: count.key)) }
        let set = PieChartDataSet(entries: entries, label: label)
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        set.colors = ChartColorTemplates.vordiplom()
        + ChartColorTemplates.joyful()
        + ChartColorTemplates.colorful()
        + ChartColorTemplates.liberty()
        + ChartColorTemplates.pastel()
        + [UIColor(red: 51 / 255, green: 181 / 255, blue: 229 / 255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        return data
    }
}

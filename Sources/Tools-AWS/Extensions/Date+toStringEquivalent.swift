//
//  Date+toStringEquivalent.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 14/12/21.
//

import Foundation

extension Date {
    func toStringEquivalent(dateFormat format: String = "yyyy-MM-dd HH:mm:ss Z") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

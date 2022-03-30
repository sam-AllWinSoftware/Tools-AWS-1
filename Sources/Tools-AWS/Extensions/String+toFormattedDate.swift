//
//  String+toFormattedDate.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 14/12/21.
//

import Foundation

extension String {
    func toFormattedDate(dateFormat format: String = "yyyy-MM-dd HH:mm:ss Z") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

//
//  Date + Extension.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 7/3/2024.
//

import Foundation

extension Date {
    func toString(format: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

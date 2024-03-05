//
//  Category.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import Foundation

struct Category: Codable, Hashable {
    let type: String
    let width: Int
    
    static let categories: [Category] = [
        Category(type: "Swimming", width: 114),
        Category(type: "Yoga", width: 78),
        Category(type: "Cardio", width: 89),
        Category(type: "Functional training", width: 169),
        Category(type: "Stretching", width: 114),
        Category(type: "Roll Relax", width: 109),
        Category(type: "Crossfit", width: 97),
        Category(type: "Pump", width: 84),
        
    ]
}

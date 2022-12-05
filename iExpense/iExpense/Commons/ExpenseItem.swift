//
//  ExpenseItem.swift
//  iExpense
//
//  Created by nicolas.e.manograsso on 05/12/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType: String, Codable, CaseIterable {
    case personal
    case business
    
    var name: String {
        self.rawValue.capitalized
    }
}

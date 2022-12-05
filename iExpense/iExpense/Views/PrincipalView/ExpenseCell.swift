//
//  ExpenseCell.swift
//  iExpense
//
//  Created by nicolas.e.manograsso on 05/12/2022.
//

import SwiftUI

struct ExpenseCell: View {
    // MARK: - Properties
    private let expense: ExpenseItem
    
    // MARK: - Initializers
    init(expense: ExpenseItem) {
        self.expense = expense
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type.name)
            }
            
            Spacer()
            Text(expense.amount, format: .currency(code: "USD"))
        }
    }
}

struct ExpenseCell_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCell(expense: ExpenseItem(name: "Expense", type: .personal, amount: 10))
    }
}

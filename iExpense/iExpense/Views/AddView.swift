//
//  AddView.swift
//  iExpense
//
//  Created by nicolas.e.manograsso on 05/12/2022.
//

import SwiftUI

struct AddView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

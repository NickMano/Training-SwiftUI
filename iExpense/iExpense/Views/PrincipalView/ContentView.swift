//
//  ContentView.swift
//  iExpense
//
//  Created by nicolas.e.manograsso on 29/11/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject var expenses = Expenses()
    @State private var showingAddNewExpense = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    ExpenseCell(expense: item)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button {
                    showingAddNewExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddNewExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    // MARK: - Methods
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

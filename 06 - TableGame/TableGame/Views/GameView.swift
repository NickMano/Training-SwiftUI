//
//  GameView.swift
//  TableGame
//
//  Created by nicolas.e.manograsso on 29/11/2022.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    private let questionsTotal: Int
    private var maxTable = 2
    
    @State private var questionsDone = 1
    
    @State private var firstValue = 2
    @State private var secondValue = 4
    
    @State private var response = 0
    @State private var score = 0
    
    @State private var showingAlert = false
    @State private var showingAlertError = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: - Initializers
    init(questions: Int = 2, table: Int = 5) {
        questionsTotal = questions
        maxTable = table
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color(.brown)
                .ignoresSafeArea()
            
            VStack {
                Text("Question \(questionsDone) of \(questionsTotal)")
                    .foregroundColor(.white)
                Text("Score: \(score)")
                    .foregroundColor(.white)
                
                
                Text("\(firstValue) x \(secondValue) =")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                TextField("", value: $response, format: .number)
                    .frame(width: 120, height: 40)
                    .multilineTextAlignment(.center)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 40)
                
                Button("Answer") {
                    onAnswer()
                }
                .principal()
                
                Button("Exit") {
                    onExit()
                }
                .principal(backgroundColor: .red)
            }
        }
        .onAppear {
            createQuestion()
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            let isFinish = questionsDone == questionsTotal
            
            Button(questionsDone < questionsTotal ? "Continue" : "Finish" ) {
                if isFinish {
                    dismiss()
                } else {
                    questionsDone += 1
                    createQuestion()
                }
            }
        } message: {
            Text(alertMessage)
        }
        .alert(alertTitle, isPresented: $showingAlertError) {
            Button("Yes") {
                dismiss()
            }
            
            Button("No", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func createQuestion() {
        firstValue = Int.random(in: 2...maxTable)
        
        let secondMaxValue = maxTable > 10 ? maxTable : 10
        secondValue = Int.random(in: 1...secondMaxValue)
    }
    
    private func onAnswer() {
        alertTitle = "Your answer is "
        
        if isCorrect() {
            alertTitle += "✅"
            score += 1
        } else {
            alertTitle += "❌"
        }
        
        alertMessage = "Score: \(score)"
        
        showingAlert.toggle()
    }
    
    private func isCorrect() -> Bool {
        response == (firstValue * secondValue)
    }
    
    private func onExit() {
        alertTitle = "Are you sure?"
        alertMessage = "You will lose your progress."
        showingAlertError.toggle()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

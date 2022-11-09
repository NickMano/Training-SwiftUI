//
//  ContentView.swift
//  WordScramble
//
//  Created by nicolas.e.manograsso on 05/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var rootWordDict: [Character: Int] = [:]
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                
                
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }.padding()
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .alert(errorTitle, isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .navigationBarItems(trailing: Button(action: startGame, label: {
                Image(systemName: "shuffle")
            }))
        }
        .onAppear(perform: startGame)
    }
    
    func isNew(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        if rootWordDict.isEmpty {
            generateRootDict()
        }
        
        var dict = rootWordDict
        word.forEach { letter in
            dict[letter] = (dict[letter] ?? 0) - 1
        }
        
        return !dict.values.contains { $0 < 0 }
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 1 else {
            newWord = ""
            return
        }
        
        guard answer != rootWord else {
            onWordError(title: "That's ilegal",
                        message: "Be more original!")
            return
        }
        
        guard isNew(word: answer) else {
            onWordError(title: "Word used already",
                        message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            onWordError(title: "Word not possible",
                        message: "You can't spell \(answer) from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            onWordError(title: "Doesn't exist \(answer)",
                        message: "Try again")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsURL)
        else {
            fatalError("Could not load start.txt from bundle.")
        }
            
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        usedWords = []
        rootWordDict = [:]
    }
    
    func generateRootDict() {
        rootWord.forEach { letter in
            rootWordDict[letter] = (rootWordDict[letter] ?? 0) + 1
        }
    }
    
    func onWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        
        showError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

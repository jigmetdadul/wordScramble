//
//  ContentView.swift
//  wordScramble
//
//  Created by Jigmet stanzin Dadul on 27/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = String()
    @State private var rootWord = String()
    
    var body: some View {
        NavigationView {
            List {
                TextField("Enter a word", text: $newWord)
                ForEach(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit() {
                addNewWord()
            }
            .onAppear(perform: {
                startGame()
            })
            .textInputAutocapitalization(.never)
        }
    }
    
    func addNewWord() {
        let word = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0 else {
            return
        }
        withAnimation {
            usedWords.insert(word, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "default"
                return
            }
        }
        fatalError("error while finding URL")
    }
}


#Preview {
    ContentView()
}

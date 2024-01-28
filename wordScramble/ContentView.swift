//
//  ContentView.swift
//  wordScramble
//
//  Created by Jigmet stanzin Dadul on 27/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String()]
    @State private var newWord = String()
    @State private var rootWord = String()
    
    var body: some View {
        NavigationStack{
            List{
                TextField("Enter a word", text: $newWord)
                ForEach(usedWords, id: \.self){ word in
                    Text(word)
                }
            }
           
        }.navigationTitle(rootWord).onSubmit {
             addNewWord( )
        }
        .textInputAutocapitalization(.never)
    }
    
    func addNewWord( ){
        let word = newWord.trimmingCharacters(in: .whitespacesAndNewlines)// removes new lines and white spaces
        guard word.count > 0 else {
            return
        }
        withAnimation {
            usedWords.insert(newWord, at: 0)
        }
        newWord = ""
    }
}

#Preview {
    ContentView()
}

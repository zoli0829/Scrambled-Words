//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct ContentView: View {
    
    @State private var letters: [Letter] = [
        Letter(id: 0, text: "A"),
        Letter(id: 1, text: "O"),
        Letter(id: 2, text: "E"),
        Letter(id: 3, text: "R"),
        Letter(id: 4, text: "N"),
        Letter(id: 5, text: "G"),
    ]
    @State private var guessedLetters: [Letter] = []
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Spacer()
                        
                        Image("orange")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        HStack {
                            ForEach(guessedLetters) { guessedLetter in
                                VStack {
                                    LetterView(letter: guessedLetter)
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 25, height: 2)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border, lineWidth: 2)
                    }
                    
                    Text("Score: 0")
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    HStack {
                        ForEach(Array(letters.enumerated()), id: \.1) { index, letter in
                            LetterView(letter: letter)
                                .onTapGesture {
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        letters[index].text = ""
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct LetterView: View {
    let letter: Letter
    
    var body: some View {
        Text(letter.text)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width:30, height: 30)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

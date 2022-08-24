//
//  ContentView.swift
//  project-2-gueesTheFlag
//
//  Created by Roro Solutions on 28/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var numOfQuestuio = 1
    @State private var isLastQuestionn = false;
    @State private var message = ""
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var buttonTitle = "continue"
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack{
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                           flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))// previous VStack code
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
            }
            .padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(buttonTitle, action: askQuestion)
        } message: {
            Text(message)
        }
        
    }
    func flagTapped(_ number: Int) {
        if numOfQuestuio == 8 {
            isLastQuestionn = true
            buttonTitle = "restart"
        }
        if number == correctAnswer {
            scoreTitle = isLastQuestionn == true ? "Game Over" : "Correct"
            score = score + 1
            message = isLastQuestionn == true ? "Your total Score is \(score)" : "Your Score is \(score)"
        } else {
            scoreTitle = isLastQuestionn == true ? "Game Over" : "Wrong!"
            message  = "This is Flag of \(countries[number])"
            
        }
        
        showingScore = true
    }
    func askQuestion() {
        if numOfQuestuio == 8 {
            score = 0
            numOfQuestuio = 0
            isLastQuestionn = false
            buttonTitle = "conntinue"
        }
        numOfQuestuio = numOfQuestuio + 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

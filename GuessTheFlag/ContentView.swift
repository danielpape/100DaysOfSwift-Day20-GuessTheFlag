//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Pape on 12/04/2021.
//

import SwiftUI

struct FlagStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black,lineWidth: 1.0))
            .shadow(color: Color.black, radius: 2)
    }
}

extension View {
    func flag() -> some View {
        self.modifier(FlagStyle())
    }
}


struct ContentView: View {
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","US","UK"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var score = 0
    @State private var flagsAsked = 0
    
    
    var body: some View {
        NavigationView{
            ZStack {
            LinearGradient(gradient: Gradient(colors:[Color.blue,Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30){
                VStack{
                    Text("Pick the flag for")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                VStack{
                    ForEach(0 ..< 3){number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .flag()
                        }
                    }
                }
                Spacer()
            }
            .alert(isPresented: $showingScore){
                Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("OK"), action: askQuestion))
            }
        }
            .navigationBarItems(trailing: Text("Score: \(score)").foregroundColor(.white))
        }
    }
    
    func flagTapped(_ number:Int){
        flagsAsked += 1
        if(number == correctAnswer){
            score += 1
            scoreTitle = "That's right!"
            scoreMessage = "Your score is \(score) out of \(flagsAsked)"
 
        } else {
            scoreTitle = "Incorrect!"
            scoreMessage = "You selected the flag of \(countries[number]) \n Your score is \(score) out of \(flagsAsked)"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

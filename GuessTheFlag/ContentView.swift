//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Pape on 12/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","US","UK"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
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
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black,lineWidth: 1.0))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                }
                Spacer()
            }
            .alert(isPresented: $showingScore){
                Alert(title: Text(scoreTitle), message: Text("Your score is x out of x"), dismissButton: .default(Text("OK"), action: askQuestion))
            }
        }
        
    }
    
    func flagTapped(_ number:Int){
        if(number == correctAnswer){
            scoreTitle = "That's right!"
        } else {
            scoreTitle = "Incorrect!"
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

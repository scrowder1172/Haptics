//
// File: BasicHapticView.swift
// Project: Haptics
// 
// Created by SCOTT CROWDER on 1/13/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct BasicHapticView: View {
    
    @State private var value1 = false
    @State private var value2 = false
    @State private var value3 = false
    @State private var value4 = false
    
    @Binding var returnToMenu: Bool
    
    var body: some View {
        VStack {
            VStack {
                Text("Haptic Feedback Expectation")
                    .font(.headline)
                    .fontDesign(.rounded)
                List {
                    Button("Heavy Impact, High Intensity") {
                        value1.toggle()
                    }
                    .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: value1)
                    
                    Button("Increase") {
                        value2.toggle()
                    }
                    .sensoryFeedback(.increase, trigger: value2)
                    
                    Button("Success") {
                        value3.toggle()
                    }
                    .sensoryFeedback(.success, trigger: value3)
                    
                    Button("Error") {
                        value4.toggle()
                    }
                    .sensoryFeedback(.error, trigger: value4)
                    
                }
                .frame(height: 250)
            }
            
            Spacer()
                .frame(height: 100)
            
            Button("Return to Menu") {
                returnToMenu.toggle()
            }
            .sensoryFeedback(.selection, trigger: returnToMenu)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    BasicHapticView(returnToMenu: .constant(true))
}

//
// File: MenuView.swift
// Project: Haptics
// 
// Created by SCOTT CROWDER on 1/13/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct MenuView: View {
    
    @State private var hapticView: String = "basic"
    @State private var showHapticView: Bool = false
    
    var body: some View {
        if showHapticView {
            if hapticView == "basic" {
                BasicHapticView(returnToMenu: $showHapticView)
            } else {
                CustomHapticView(returnToMenu: $showHapticView)
            }
        } else {
            VStack {
                Text("Select haptic view")
                    .font(.headline)
                    .fontDesign(.rounded)
                Picker("Haptic View", selection: $hapticView) {
                    Text("Basic").tag("basic")
                    Text("Custom").tag("custom")
                }
                .pickerStyle(.segmented)
                .sensoryFeedback(.selection, trigger: hapticView)
                
                Button("Practice Haptics") {
                    showHapticView.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    MenuView()
}

//
// File: CustomHapticView.swift
// Project: Haptics
// 
// Created by SCOTT CROWDER on 1/13/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 

import CoreHaptics
import SwiftUI

struct CustomHapticView: View {
    
    @State private var hapticEngine: CHHapticEngine?
    
    @Binding var returnToMenu: Bool
    
    var body: some View {
        VStack{
            VStack {
                Button("Play custom haptic") {
                    playCustomHaptic()
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
                .frame(height: 100)
            
            Button("Return to menu") {
                returnToMenu.toggle()
            }
            .sensoryFeedback(.selection, trigger: returnToMenu)
            .buttonStyle(.borderedProminent)
        }
        .onAppear(perform: prepareHapticEngine)
    }
    
    private func prepareHapticEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("There was an error starting the haptic engine: \(error.localizedDescription)")
        }
        
    }
    
    private func playCustomHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events: [CHHapticEvent] = []
        
        for i in stride(from: 0, to: 1, by: 0.3) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: .zero)
        } catch {
            print("There was an error playing the haptic pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CustomHapticView(returnToMenu: .constant(true))
}

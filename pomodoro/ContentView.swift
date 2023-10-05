//
//  ContentView.swift
//  pomodoro
//
//  Created by K on 05/10/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var timeRemaining: Int = 1500 // 25 minutes in seconds
    @State private var timer: AnyCancellable?
    
    var body: some View {
        VStack {
            Text("\(timeRemaining / 60):\(String(format: "%02d", timeRemaining % 60))")
                .font(.largeTitle)
            
            HStack {
                Button("Start") {
                    self.startTimer()
                }
                
                Button("Stop") {
                    self.stopTimer()
                }
            }
        }
    }
    
    func startTimer() {
        // Invalidate any existing timer
        timer?.cancel()
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    // Pomodoro completed - you can add more logic here for breaks or notifications
                    self.stopTimer()
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
        timeRemaining = 1500 // Resetting to 25 minutes
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

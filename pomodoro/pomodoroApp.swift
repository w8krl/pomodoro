//
//  pomodoroApp.swift
//  pomodoro
//
//  Created by K on 05/10/2023.
//

import SwiftUI
import AppKit

@main
struct pomodoroApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?
    var statusBarItem: NSStatusItem!
    var timeRemaining: Int = 1500
    var timer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        updateMenuBarTitle()
        statusBarItem.button?.action = #selector(toggleTimer)
    }

    @objc func toggleTimer() {
        if timer == nil {
            startTimer()
        } else {
            stopTimer()
        }
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeRemaining = 1500
        updateMenuBarTitle()
    }

    @objc func updateTime() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateMenuBarTitle()
        } else {
            stopTimer()
        }
    }

    func updateMenuBarTitle() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        statusBarItem.button?.title = "\(minutes):\(String(format: "%02d", seconds))"
    }
}


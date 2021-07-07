//
//  ContentView.swift
//  notifications
//
//  Created by Maxime Britto on 06/07/2021.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var displayedMessage = ""
    @State var canDisplayNotification = false
    var body: some View {
        VStack {
            Text(displayedMessage)
                .padding()
            
            if canDisplayNotification {
                Button("Schedule notification") {
                    scheduleNotification()
                }
            } else {
                Button("Request notification permission") {
                    requestNotificationPermission()
                }
            }
        }.task {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                canDisplayNotification = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func scheduleNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Purple Giraffe"
        notificationContent.body = "Je code donc je suis"
        notificationContent.interruptionLevel = .timeSensitive
        notificationContent.relevanceScore = 0.9
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                displayedMessage = error.localizedDescription
            } else {
                displayedMessage = "Notification programmée. Arrivée prévue dans 5 secondes"
            }
        }
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                // Handle the error here.
                displayedMessage = error.localizedDescription
            }
            
            canDisplayNotification = granted
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
